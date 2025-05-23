require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class RUST < Package
  property :rust_channel, :rust_features, :rust_options, :rust_release_profile, :rust_targets, :pre_rust_options, :rust_build_extras, :rust_install_extras

  def self.build
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    @channel_flag = @rust_channel.to_s.empty? ? '' : "+#{@rust_channel}"
    @features = @rust_features.to_s.empty? ? '' : "--features #{@rust_features}"
    @profile = @rust_release_profile.to_s.empty? ? 'release' : @rust_release_profile
    extend ReportBuildsystemMethods
    print_buildsystem_methods

    unless @rust_channel.to_s.empty?
      system rust_env, "rustup install --force #{@rust_channel}"
      fix_interpreter_path("#{CREW_PREFIX}/share/rustup/toolchains")
    end
    system rust_env, "rustup target add #{@rust_targets}" unless @rust_targets.to_s.empty?
    system rust_env, "#{@pre_rust_options} cargo #{@channel_flag} fetch"
    system rust_env, "#{@pre_rust_options} cargo #{@channel_flag} build \
      --profile=#{@profile} \
      #{@features} \
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

    system rust_env, "cargo #{@channel_flag} install \
      --profile=#{@profile} \
      --offline \
      --no-track \
      --path . \
      #{@features} \
      #{@rust_options} \
      --root #{CREW_DEST_PREFIX}"
    @rust_install_extras&.call
  end
end
