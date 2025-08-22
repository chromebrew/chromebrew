require 'io/console'
require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/convenience_functions'
require_relative '../lib/misc_functions'

class Command
  def self.diskstat(show_all = false)
    color_list = [
      [:lightred, :no_bold],
      [:lightcyan, :no_bold],
      [:lightpurple, :no_bold],
      [:yellow, :no_bold],
      [:lightblue, :no_bold],
      [:lightgreen, :no_bold],
      :red,
      :cyan,
      :purple,
      :orange,
      :blue,
      :green
    ]

    terminal_w = !IO.console&.console_mode || IO.console&.winsize == [0, 0] ? 80 : IO.console&.winsize&.last

    # Calculate disk size for all packages and sort in ascending order
    size_of_all_packages = Dir["#{CREW_META_PATH}/*.filelist"].map do |filelist|
      pkg_name = File.basename(filelist, '.filelist')
      size     = ConvenienceFunctions.read_filelist(filelist, always_calcuate_from_disk: true)

      [pkg_name, size]
    end.sort_by(&->((k, v)) { -v })

    total_size     = size_of_all_packages.sum(&:last).to_f # Total size of all installed packages
    other_size     = total_size                            # Total size of all installed packages, excluding the top 12 one
    bar_length     = 0
    bar_components = result[..11].map.with_index do |(k, v), i|
      length      = (v / total_size * terminal_w).to_i
      bar_length += length
      other_size -= v

      ("\u2501" * length).send(*color_list[i])
    end

    bar_components << ("\u2501" * (terminal_w - bar_length)).gray(:no_bold)

    if show_all
      printf "\nAll Chromebrew packages are shown below, sorted by occupied disk space\n\n"
    else
      printf "\nOnly the top 12 packages are shown below, sorted by occupied disk space\n\n"
    end

    printf "%s" * 13, *bar_components
    printf "\n\n"

    result[..11].each.with_index do |(pkg_name, size), i|
      printf("%s %s ", ' '.send(*color_list[i], :background), pkg_name)
    end

    printf "%s Other packages", ' '.gray(:background)
    printf "\n\n%-30s     %s\n\n", 'Package', 'Size (in descending order)'

    if show_all
      result.each do |(pkg_name, size)|
        printf "%-30s     %s\n", k, MiscFunctions.human_size(size)
      end
    else
      result[..11].each do |(pkg_name, size)|
        printf "%-30s     %s\n", k, MiscFunctions.human_size(size)
      end

      printf "\n%-30s     %s", 'Other packages', MiscFunctions.human_size(other_size)
    end

    printf "\n%-30s     %s\n\n", 'Total', MiscFunctions.human_size(total_size)
  end
end
