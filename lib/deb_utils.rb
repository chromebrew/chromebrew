module DebUtils
  def extract_deb(file, target)
    # extract_deb: unarchive .deb files
    # Usage: extract_deb(<file>, <target (optional)>)
    #   file: a .deb archive file
    #   target: (optional) a specified file to extract from archive, should be passed in regex or string
    #
    # Example:
    #   extract_deb('example.deb', 'test.txt') # extract `test.txt` from example.deb
    #   extract_deb('example.deb', /data\..*/) # extract files from example.deb with filenames matching the /data\..*/ regex
    #   extract_deb('example.deb', /*/)        # extract all files from example.deb
    #
    file_found = false
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
      if target.is_a?(String) and name == target
        # if target is passed as string, write matched file to filesyetem and exit function
        # write to filesystem
        File.open(name, 'wb') {|dst_fileIO| dst_fileIO.write(fileContent) }
        # exit function
        return true
      elsif target.is_a?(Regexp) and name =~ target
        # if target is passed as regex, write matched file to filesyetem and continue
        # searching for another matched file until EOF
        # write to filesystem
        File.open(name, 'wb') {|dst_fileIO| dst_fileIO.write(fileContent) }
        file_found = true
      end
    end
    abort "Target #{target.inspect} not found in archive. :/".lightred unless file_found
  end
end
