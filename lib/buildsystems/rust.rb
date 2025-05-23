require_relative '../package'
require_relative '../require_gem'
require_relative '../report_buildsystem_methods'

class RUST < Package
  property :rust_features, :rust_options, :rust_release_profile, :rust_targets, :pre_rust_options, :rust_build_extras, :rust_install_extras

  def self.build
    rust_env =
      {
                  LD: 'mold',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    extend ReportBuildsystemMethods
    print_buildsystem_methods

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
