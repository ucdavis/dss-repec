namespace :papers do
  desc "Import existing .rdf papers given path (e.g. ./papers)"
  task :import, [:path] => :environment do |task, args|
    if args.path.nil?
      STDERR.puts "Must specify a path as first argument."
      exit(-1)
    end

    begin
      files = Dir.entries(args.path).map{|f| File.realpath(args.path + "/" + f)}
    rescue Errno::ENOENT => e
      STDERR.puts "Error while getting files in given path (#{args.path}): #{e}"
      exit(-1)
    end

    VALID_FIELDS = ["Template-Type", "Author-Name", "Author-Name-First", "Author-Name-Last", "Author-Workplace-Name", "Title", "Abstract", "File-URL", "File-Format", "Number", "KeyWords", "Keywords", "Length", "Handle", "Creation-Date", "Classification-JEL"]

    # Helper method to extract a field (e.g. 'Content: 43' => 'Content') if any
    def field_from(line)
      colon_ind = line.index(":")
      return nil unless colon_ind
      field = line[0..colon_ind - 1]
      return nil unless VALID_FIELDS.include?(field)
      value = line[colon_ind + 1..-1]
      value = value[1..-1] if value[0] == " "
      return field, value
    end

    max_field = 0

    files.each do |filename|
      # Filter out non-.rdf files
      next unless filename.downcase.end_with?(".rdf")

      file = File.new(filename, 'r', encoding: 'iso-8859-1')

      paper = Paper.new
      authors = []

      # Use file.gets() as we may need to skip lines within the 'while' loop
      while (line = file.gets) do
        field, value = field_from(line)
        next unless field

        case field
        when "Template-Type"
          # string, max found 17, always 'ReDIF-Paper 1.0'
        when "Author-Name"
          # string, max found 32
          authors << value.gsub(/\s+/, ' ') # clean up excessive whitespace
        when "Author-Name-First"
          # string, max found 30
        when "Author-Name-Last"
          # string, max found 16
        when "Author-Workplace-Name"
          # string, max found 57
        when "Title"
          # string, max found 132
          paper.title = value
        when "Abstract"
          # Abstract may be multiple lines. Collect them together.
          # Abstract likely begins on this line, e.g. "Abstract: This is",
          # so start by extracting "This is"
          abstract = value
          while (line = file.gets) do
            field, value = field_from(line)
            if field
              # Be kind, rewind. (to ensure while loop catches this line)
              file.seek -line.length, IO::SEEK_CUR
              break
            else
              abstract += line
            end
          end
          paper.abstract = abstract
        when "File-URL"
          # string, max found 54
        when "File-Format"
          # string, max found 17, apparently always 'Application/pdf'
        when "Number"
          # integer, unique number used in handle?
          paper.paper_number = value
        when "KeyWords", "Keywords"
          # string, max found 297, needs some cleaning up
          paper.keywords = value
        when "Length"
          # integer, The number of pages the document would have if printed.
          paper.paper_length = value.to_i
        when "Handle"
          # investigate, special field, e.g. RePEc:cda:wpaper:05-16, max length was 24
          # This uniquely identifies the paper. It consists of your RePEc handle, the series handle, and then paper number (which must be unique).
        when "Creation-Date"
          # date, displayed like '20030109', max length 10
          # The date is the date the paper was written, not the date the template was added.
          paper.creation_date = Date.parse(value)
        when "Classification-JEL"
          # string list, max length 49, codes from https://ideas.repec.org/j/
          paper.classification_jel = value
        else
          puts "Unknown field: #{field}"
        end
      end

      file.close
      paper.authors = authors.to_json
      paper.save!
    end
  end
end
