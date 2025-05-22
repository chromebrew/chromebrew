require 'package'
require 'require_gem'

class RUST < Package
  property :rust_features, :rust_options, :rust_release_profile, :rust_targets, :pre_rust_options, :rust_build_extras, :rust_install_extras

  def self.build
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    puts "Additional #{superclass.to_s.capitalize} options being used:".orange
    method_list = methods.grep(/rust_/).delete_if { |i| send(i).blank? }
    require_gem 'method_source'
    method_blocks = []
    method_strings = []
    method_list.sort.each do |method|
      @method_info = send method
      if @method_info.is_a? String
        method_strings << "#{method}: #{@method_info}".orange
      else
        method_blocks << @method_info.source.to_s.orange
      end
    end
    puts method_strings
    puts method_blocks

    system rust_env, "rustup target add #{@rust_targets}" unless @rust_targets.to_s.empty?
    system rust_env, "#{@pre_rust_options} cargo fetch"
    system rust_env, "#{@pre_rust_options} cargo build \
      --profile=#{@rust_release_profile.to_s.empty? ? 'release' : @rust_release_profile} \
      #{@rust_features.to_s.empty? ? '' : "--features #{@rust_features}"} \
      #{@rust_options}"
    @rust_build_extras&.call
  end

  def self.install
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    system rust_env, "cargo install \
      --profile=#{@rust_release_profile.to_s.empty? ? 'release' : @rust_release_profile} \
      --offline \
      --no-track \
      --path . \
      #{@rust_features.to_s.empty? ? '' : "--features #{@rust_features}"} \
      #{@rust_options} \
      --root #{CREW_DEST_PREFIX}"
    @rust_install_extras&.call
  end
end
