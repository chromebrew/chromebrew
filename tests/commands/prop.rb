require 'minitest/autorun'
require_relative '../../commands/prop'

class PropCommandTest < Minitest::Test
  def test_no_arguments
    expected_output = <<~EOT
      Explain the purpose of various package boolean properties.
      Usage: crew prop <property>
      Available properties: arch_flags_override, conflicts_ok, git_clone_deep, git_fetchtags, gnome, is_fake, is_musl, is_static, no_compile_needed, no_compress, no_env_options, no_fhs, no_git_submodules, no_links, no_lto, no_patchelf, no_shrink, no_source_build, no_strip, no_upstream_update, no_zstd, patchelf, print_source_bashrc, run_tests
    EOT
    assert_output expected_output, nil do
      Command.prop(nil)
    end
  end

  def test_no_env_options_property
    expected_output = <<~EOT
      Use the 'no_env_options' property for packages that do not require
      environment options or to override the default options.
    EOT
    assert_output expected_output, nil do
      Command.prop('no_env_options')
    end
  end

  def test_is_static_property
    expected_output = "Use the 'is_static' property for packages which do not require shared dependencies.\n"
    assert_output expected_output, nil do
      Command.prop('is_static')
    end
  end
end
