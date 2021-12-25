def human_size (bytes)
  kilobyte = 1024.0
  megabyte = kilobyte * kilobyte
  gigabyte = megabyte * kilobyte
  if bytes < kilobyte
    units = 'B'
    size = bytes
  end
  if bytes >= kilobyte and bytes < megabyte
    units = 'KB'
    size = bytes / kilobyte
  end
  if bytes >= megabyte and bytes < gigabyte
    units = 'MB'
    size = bytes / megabyte
  end
  if bytes >= gigabyte
    units = 'GB'
    size = bytes / gigabyte
  end
  return sprintf('%.2f %s', size, units)
end
