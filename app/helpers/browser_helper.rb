module BrowserHelper
  # file_size = nil implies entry is a directory
  def dir_entry(timestamp, body, url, file_size = nil)
    str = Time.at(timestamp).strftime("%-m/%-d/%Y").rjust(10) + " " + Time.at(timestamp).strftime("%l:%M %p")
    if file_size.nil?
      return (str + "&lt;dir&gt;".rjust(19) + " " + link_to(body, url)).html_safe
    else
      return (str + file_size.to_s.rjust(13) + " " + link_to(body, url)).html_safe
    end
  end

  # Loads the given 'url' and returns its 'Location' header, if any.
  # This gets around a limitation of ActiveStorage where it can only provide
  # links to 302s which then lead to the original file. This method of returning
  # a 302 instead of a 200 is apparently incompatible with the RePEc service.
  def resolve_redirect(url)
    return nil unless url

    uri = URI.parse(url)

    response = Net::HTTP.get_response(uri)

    response['Location']
  end
end
