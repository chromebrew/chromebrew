def extract_deb(file, target = nil)
  # extract_deb: unarchive .deb files
  # Usage: extract_deb(<file>, <target (optional)>)
  #   file: a .deb archive file
  #   target: (optional) a specified file to extract from archive, should be passed in regex
  #
  # Example:
  #   extract_deb('example.deb', /data\..*/) # extract files from example.deb with filenames matching the /data\..*/ regex
  #   extract_deb('example.deb')             # extract all files in example.deb
  #
  file_found = false if target
  src_fileIO = File.open(file, 'rb')
  # get first line of the given file, should be a signature string (`!<arch>\n`) if it is a valid deb file
  signature = src_fileIO.gets

  abort 'Malformed archive :/' unless signature == "!<arch>\n"

  # process each file in archive
  while (line = src_fileIO.gets) do
    # read file meta
    name, modtime, uid, gid, mode, size, end_char = \
      line.scan(/(.{16})(.{12})(.{6})(.{6})(.{8})(.{10})(.{1})/).flatten.map(&:strip)

    # check ending byte
    abort "Malformed archive :/" unless end_char == '`'

    # capture file in archive with given offset bytes (file size)
    fileContent = src_fileIO.read(size.to_i)

    # filter filename if a target file is specified
    if target and name =~ target
      file_found = true
    elsif target
      next
    end

    File.open(name, 'wb') do |dst_fileIO|
      # write to filesystem
      dst_fileIO.write(fileContent)
    end
  end
  abort "#{target}: File not found in archive :/" if target and !file_found
end
