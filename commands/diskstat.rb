require 'io/console'
require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/convenience_functions'
require_relative '../lib/misc_functions'

class Command
  def self.diskstat(show_all, count)
    bar_chars  = %W[\u2588 \u2592]
    color_list = [
      %i[lightred no_bold],
      %i[lightcyan no_bold],
      %i[lightpurple no_bold],
      %i[yellow no_bold],
      %i[lightblue no_bold],
      %i[lightgreen no_bold],
      :red,
      :cyan,
      :purple,
      :orange,
      :blue,
      :green
    ]

    terminal_w = !IO.console&.console_mode || IO.console&.winsize == [0, 0] ? 80 : IO.console&.winsize&.last

    total_disk_space, used_disk_space = `df -B1 #{CREW_PREFIX}`.lines.last.split[1..2].map(&:to_i)
    user_dir_size = `du -bc #{ENV.fetch('XDG_CONFIG_HOME', '')} #{ENV.fetch('XDG_CACHE_HOME', '')} #{ENV.fetch('XDG_DATA_HOME', '')}`.lines.last.partition(' ').first.to_i

    # Calculate disk size for all packages and sort in ascending order
    size_of_all_packages = Dir["#{CREW_META_PATH}/*.filelist"].map do |filelist|
      pkg_name = File.basename(filelist, '.filelist')
      size     = ConvenienceFunctions.read_filelist(filelist, always_calcuate_from_disk: true).first

      [pkg_name, size]
    end.sort_by(&->((_, size)) { -size })

    total_size     = size_of_all_packages.sum(&:last).to_f # Total size of all installed packages
    other_size     = total_size                            # Total size of all installed packages, excluding the top 12 one
    bar_length     = 0
    bar_components = size_of_all_packages[...24].map.with_index do |(_, size), i|
      length      = (size / total_size * terminal_w).to_i
      bar_length += length

      (bar_chars[i > 12 ? 1 : 0] * length).send(*color_list[i % 12])
    end

    bar_components << (bar_chars[1] * (terminal_w - bar_length)).gray(:no_bold)

    if show_all
      printf <<~EOT

        All Chromebrew packages are shown below, sorted by occupied disk space:

      EOT
    else
      printf <<~EOT

        Only the top #{count} packages are shown below, sorted by occupied disk space:
        (use `crew diskstat --all` to show all installed packages)

      EOT
    end

    printf '%s' * 25, *bar_components
    printf "\n\n"

    size_of_all_packages[...24].each.with_index do |(pkg_name, _), i|
      printf '%s %s ', bar_chars[i >= 12 ? 1 : 0].send(*color_list[i % 12]), pkg_name
    end

    printf '%s Other packages', bar_chars[1].gray
    printf "\n\n%-50s     %s\n\n", 'Package', 'Size (in descending order)'

    if show_all
      size_of_all_packages.each do |(pkg_name, size)|
        printf "%-50s     %s\n", pkg_name, MiscFunctions.human_size(size)
      end
    else
      size_of_all_packages[...count].each do |(pkg_name, size)|
        other_size -= size
        printf "%-50s     %s\n", pkg_name, MiscFunctions.human_size(size)
      end

      printf "\n%-50s     %s", 'Other packages', MiscFunctions.human_size(other_size)
    end

    printf "\n%-50s     %s\n", 'Runtime data size (user data/runtime cache)', MiscFunctions.human_size(user_dir_size)
    printf "%-50s     %s\n", 'Total package size', MiscFunctions.human_size(total_size)
    printf "%-50s     %s\n", 'Used disk size', MiscFunctions.human_size(used_disk_space)
    printf "%-50s     %s\n\n", 'Total disk size', MiscFunctions.human_size(total_disk_space)
  end
end
