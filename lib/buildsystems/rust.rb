require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class RUST < Package
  property :rust_channel, :rust_flags, :rust_features, :rust_install_path, :rust_options, :rust_packages, :rust_release_profile, :rust_targets, :pre_rust_options, :rust_build_extras, :rust_install_extras

  def self.build
    @rustflags = ENV.fetch('RUSTFLAGS', nil) + ' ' + @rust_flags
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil),
           RUSTFLAGS: @rustflags
      }.transform_keys(&:to_s)

    @channel_flag = @rust_channel.to_s.empty? ? '' : "+#{@rust_channel}"
    @features = @rust_features.to_s.empty? ? '' : "--features #{@rust_features}"
    @profile = @rust_release_profile.to_s.empty? ? 'release' : @rust_release_profile
    @rust_install_path ||= '.'
    @packages = @rust_packages.to_s.empty? ? '' : @rust_packages.split.map { |p| "--package #{p}" }.join(' ')
    extend ReportBuildsystemMethods
    print_buildsystem_methods

    unless @rust_channel.to_s.empty?
      system rust_env, "rustup install --force #{@rust_channel}"
      expand_binaries_and_fix_interpreter_path("#{CREW_PREFIX}/share/rustup/toolchains")
    end
    system rust_env, "rustup target add #{@rust_targets}" unless @rust_targets.to_s.empty?
    system rust_env, "#{@pre_rust_options} cargo #{@channel_flag} fetch"
    system rust_env, "#{@pre_rust_options} cargo #{@channel_flag} build \
      --profile=#{@profile} \
      #{@features} \
      #{@rust_options} \
      #{@packages}"
    @rust_build_extras&.call
  end

  def self.install
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil),
           RUSTFLAGS: @rustflags
      }.transform_keys(&:to_s)

    @rust_install_path.split.each do |path|
      system rust_env, "cargo #{@channel_flag} install \
        --profile=#{@profile} \
        --offline \
        --no-track \
        --path #{path} \
        #{@features} \
        #{@rust_options} \
        #{@packages} \
        --root #{CREW_DEST_PREFIX}"
    end
    @rust_install_extras&.call
  end
end
