require 'minitest/autorun'
require_relative '../../lib/const'
require_relative '../../lib/package'
require_relative '../../lib/package_utils'
require_relative '../../lib/buildsystems/pip'
require_relative '../../tools/getrealdeps'

def test_wrapper(input_file, expected_pkg_file, deps, name: 'example', pkg_class: Package)
  # Create the Package (or superclass) object, assigning it the relevant values.
  pkg = Class.new(pkg_class)
  pkg.name = name

  # Create the temporary package file, write the content to it, and rewind the stream.
  pkg_file = Tempfile.create
  pkg_file.puts input_file
  pkg_file.rewind

  # Write the dependencies to the temporary package file using the created object.
  write_deps(pkg_file.path, deps, pkg)

  # Close the temporary package file.
  pkg_file.close

  # Read the actual package file into a variable so we can delete it after.
  actual_pkg_file = File.read(pkg_file)

  # Delete the temporary package file.
  File.unlink(pkg_file.path)

  # Remove the file copied to CREW_LOCAL_REPO_ROOT/packages, as to not leave any residue.
  File.unlink("#{CREW_LOCAL_REPO_ROOT}/packages/#{pkg}.rb") unless FileUtils.identical?("#{CREW_LOCAL_REPO_ROOT}/packages/#{pkg}.rb", File.join(CREW_PACKAGES_PATH, "#{pkg}.rb"))

  # Test that the expected package file and the actual package file are the same.
  assert_equal(expected_pkg_file, actual_pkg_file)
end

class GetRealDepsTest < Minitest::Test
  def test_add_single_dependency_to_empty
    deps = ['libcanberra']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libcanberra' # R
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_add_single_dependency_in_order
    deps = ['banner']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'a2png'
        depends_on 'lzlib'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'a2png'
        depends_on 'banner' # R
        depends_on 'lzlib'
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_add_multiple_dependencies_in_order
    deps = %w[libcanberra banner]
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'lzlib'
        depends_on 'a2png'
        depends_on 'libmaxminddb'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'a2png'
        depends_on 'banner' # R
        depends_on 'libcanberra' # R
        depends_on 'libmaxminddb'
        depends_on 'lzlib'
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_replace_build_dependency
    deps = ['json_c']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'a2png'
        depends_on 'json_c' => :build
        depends_on 'lzlib'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'a2png'
        depends_on 'json_c' # R
        depends_on 'lzlib'
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_add_special_dependency_to_empty
    deps = []
    input_file = <<~EOF
      class Example < Pip
        binary_sha256({})
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Pip
        binary_sha256({})

        depends_on 'python3' # R
      end
    EOF
    pkg_class = Pip

    test_wrapper(input_file, expected_pkg_file, deps, pkg_class: pkg_class)
  end

  def test_simple_dependency_exception
    deps = ['gcc_build']
    input_file = <<~EOF
      class Libssp < Package
        binary_sha256({})
      end
    EOF
    expected_pkg_file = <<~EOF
      class Libssp < Package
        binary_sha256({})
      end
    EOF
    name = 'libssp'

    test_wrapper(input_file, expected_pkg_file, deps, name: name)
  end

  def test_regex_dependency_exception
    deps = %w[llvm9_cheesecake asciinema]
    input_file = <<~EOF
      class Llvm21_build < Package
        binary_sha256({})

        depends_on 'glm'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Llvm21_build < Package
        binary_sha256({})

        depends_on 'asciinema' # R
        depends_on 'glm'
      end
    EOF
    name = 'llvm21_build'

    test_wrapper(input_file, expected_pkg_file, deps, name: name)
  end

  def test_add_single_duplicate_dependency
    deps = ['libnftnl']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libnftnl'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libnftnl'
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_add_runtime_duplicate_dependency
    deps = %w[abcde libpng]
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'glm'
        depends_on 'libpng' # R
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'abcde' # R
        depends_on 'glm'
        depends_on 'libpng' # R
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_add_special_duplicate_dependency
    deps = ['python3']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libnftnl'
        depends_on 'python3' # R
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libnftnl'
        depends_on 'python3' # R
      end
    EOF
    pkg_class = Pip

    test_wrapper(input_file, expected_pkg_file, deps, pkg_class: pkg_class)
  end

  def test_remove_runtime_dependency
    deps = ['libspng']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'qt5_x11extras' # R
        depends_on 'libmatroska'
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libmatroska'
        depends_on 'libspng' # R
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_remove_privileged_dependency
    deps = ['libspng']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'haveged' # R
        depends_on 'libmms'
        depends_on 'ruby' # R
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libmms'
        depends_on 'libspng' # R
        depends_on 'ruby' # R
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end

  def test_does_not_remove_build_dependency
    deps = ['libspng']
    input_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libmatroska'
        depends_on 'ninja' => :build
      end
    EOF
    expected_pkg_file = <<~EOF
      class Example < Package
        binary_sha256({})

        depends_on 'libmatroska'
        depends_on 'libspng' # R
        depends_on 'ninja' => :build
      end
    EOF

    test_wrapper(input_file, expected_pkg_file, deps)
  end
end
