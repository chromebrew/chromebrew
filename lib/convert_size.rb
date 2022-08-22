def human_size(bytes)
  kilobyte = 1024.0
  megabyte = kilobyte * kilobyte
  gigabyte = megabyte * kilobyte
  if bytes < kilobyte
    units = 'B'
    size = bytes
  end
  if (bytes >= kilobyte) && (bytes < megabyte)
    units = 'KB'
    size = bytes / kilobyte
  end
  if (bytes >= megabyte) && (bytes < gigabyte)
    units = 'MB'
    size = bytes / megabyte
  end
  if bytes >= gigabyte
    units = 'GB'
    size = bytes / gigabyte
  end
  return format('%.2f %s', size, units)
end
