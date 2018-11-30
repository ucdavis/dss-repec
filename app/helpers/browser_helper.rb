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
end
