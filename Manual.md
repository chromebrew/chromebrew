# Purpose

The purpose of this manual is to properly document the crew command with a rundown of function and/or variable usage. Note that this manual does not include documentation of Ruby functions and variables. A basic understanding of Ruby, shell scripting and Linux is a prerequisite for package development.
> `#`'s are used as placeholders/wild-cards within this Manual.

***

## The `crew` command
Chromebrew is a third-party package manager that interacts with ChromeOS using the `shell` and `ruby` programming languages. The `crew` command provided by Chromebrew implements a simple means to install and maintain packages native to the operating system using scripts found in `/usr/local/lib/crew/packages`. Each script contains the instructions to build and install a package. The `crew` command can also be used to update and remove packages.
***

# Build lifecycle
The crew build life-cycle consists of the stages as follows:

1. `fetch` - During the fetch phase `crew` uses `curl --ssl`  to fetch the package
2. `extract` - Once the the package has been fetched, `crew` extracts the package
3. `self.prebuild` - Only `sed` commands should be run during this stage - if provided
    - During this stage `crew` `cd`'s into the extracted directory, and stays there until the `preinstall` stage
4. `self.patch` - Only `patch` commands should be used during this stage - if provided
5. `self.build` - Package is compiled and/or configured
6. `self.check` - Package is then checked - If provided
7. `self.preinstall` - Pre-install checks/edits are done - If provided
8. `self.install` - Commands to install to `#{CREW_DEST_DIR}` are run
    - This is the ONLY necessary function
9. `self.postinstall` - Post-install checks/edits are done - If provided
10. `package`
    - Only binary packages call this stage
       - Contents are checked and packaged, then installed to `#{CREW_PREFIX}`
***

## Binary
Binary packages follow a different set of rules then source packages.
> `crew build` is used to build binaries
Only the functions `self.preinstall` and `self.postinstall` are run during a binary package install.
`crew` requires a few things to exist in the archive in order to install a binary package.

- `dlist`: A list of directories used/installed to by the package
- `filelist`: A list of all files included in the package
***

## Variables

The required package variables are as follows: - [Rundown](#rundown)

- `class # < Package` - The `#` must be name of the name of your package. It must start with a capital and be the same as the filename. (`#.rb`)
- `description`  - Is the description of the package.
- `homepage`  - Is the homepage of the package.
- `license`  - Is the license used by the package.
- `version`  - Is the package version.
- `compatibility`  - Which architectures the package can operate on.
- `source_url`  Is the URL where the source package can be found.<sup>[More](#More)</sup>
- `source_sha256`  - The checksum for the package which will be downloaded from the `source_url`.

### Preset Constants

Some commonly used preset constants are shown below:
> All of these constants can displayed using the `crew const` command

#### Related to filesystem path
- `#{CREW_PREFIX}` - The prefix used by `crew` , `/usr/local` by default.
- `#{CREW_LIB_PREFIX}` - The `LIB` prefix used by `crew`, `#{CREW_PREFIX}/lib` by default. (`#{CREW_PREFIX}/lib64` on `x86_64`)
- `#{CREW_DEST_DIR}` - The `DESTDIR` variable used by `crew`, `#{CREW_PREFIX}/tmp/crew/dest` by default.
- `#{CREW_DEST_PREFIX}` - The `DESTDIR` variable prefix used by `crew`, `#{CREW_DEST_DIR}/usr/local` by default.
- `#{CREW_MAN_PREFIX}` - Useful for building man pages, `#{CREW_PREFIX}/share/man` by default.
- `#{CREW_DEST_LIB_PREFIX}` - The `DESTDIR` `LIB` prefix, `#{CREW_DEST_PREFIX}/lib` by default. (`#{CREW_DEST_PREFIX}/lib64` on `x86_64`)
- `#{CREW_DEST_HOME}` - The `DESTDIR` home variable, `#{CREW_DEST}/#{HOME}` by default.
- `#{HOME}` - Variable used by `crew` for `$HOME`
- `#{ARCH}` - Variable used by `crew` for `$(uname -m)`
- `#{CREW_NPROC}` - Variable used by `crew` for `$(nproc)`

#### Related to buildsystems
- `#{CREW_OPTIONS}` - The preset options for `./congifure` <sup>[Equals](#eq)</sup>
- `#{CREW_MESON_OPTIONS}` - The preset options for `meson setup`
- `#{CREW_CMAKE_OPTIONS}` - The preset options for `cmake`
***

## Functions

Required functions are as follows: - [Rundown](#rundown)

- `def self.build` - Contains commands used to build/compile the software.
- `def self.install` - Should be used for `# install` but is not required to be defined. - [Rundown]

### Additional Functions

Optional functions are as follows:

- `def self.preflight` - Can be used to define functions<sup>(Or commands)</sup> that should be used to check if the requirements for installing this package are met.
- `def self.prebuild` - Can be used to define functions<sup>(Or commands)</sup> that should be used to edit various files.
- `def self.patch` - Can be used to define functions<sup>(Or commands)</sup> that should be used to `patch` various files.
- `def self.preinstall` - Can be used to define functions<sup>(Or commands)</sup> that should happen in `pre`-install.
- `def self.check` - Can be used to define functions<sup>(Or commands)</sup> that should be used to check the compile binary.
- `def self.postinstall` - Can be used to define functions<sup>(Or commands)</sup> that should happen in `post`-install.
- `def self.remove` - Can be used to define functions<sup>(Or commands)</sup> that should run after the package removes by the user.
***

- `is_fake` - Can be used to label package as meta.
***

# Rundown

The rundown of what each function and variable are/(can be) used for follows.

A simple example ruby script can be found on the [Wiki](https://github.com/chromebrew/chromebrew/wiki/Creating-a-package).
```ruby
require 'package' # Optional: not neccessary now, must occur within each `.rb` before #7283

class Template < Package            # Notice the capitals, EG: 'I3' - would be used for an 'i3' package
  description 'The template script' # Notice the indent, should contain no more than one line of text
  homepage '#'                      # Notice the same indent, EG: 'https://i3wm.org/' - Would be used for an 'i3' Package
  version 'version#-revision#'      # EG: 4.18.2-1 - Where '4.18.2' is the version and '1' is the revision - Omit revision on new packages
  license '#'                       # License of this package, cannot be empty
  compatibility '#'                 # Can contain 'all', or a list of supported architectures each separated by a space
  source_url '#'                    # The URL from which the source of the package can be downloaded
  source_sha256 '#'                 # The SHA256 checksum of the downloaded source package

  depends_on '#'           # Soft where this package depends on
  depends_on '#' => :build # Only required when the package is built from source

  def self.preflight # Optional: For preflight checks, not required
    system '#'       # Replace '#' with a disk space check, for example
  end

  def self.prebuild # For sed operations, not required
    system '#' # Replace '#' with a sed operation
  end

  def self.patch # For patch operations, not required
    system '#' # Replace '#' with a patch operation
  end

  def self.build # Contains the commands which compile the package, required if package con be compiled
    system '#' # Replace '#' with commands to compile the package
    system '#' # Should contain something like, "./configure #{CREW_OPTIONS}"
    system '#' # Use in case additions commands are required
    system '#' # Should contain something like, "'make -j$(nproc)'"
  end

  def self.check # For commands to check the build quality, called by 'crew build'
    system '#'
  end

  def self.preinstall # For pre-install conditions, not required
    system '#'
  end

  def self.install # For make install, required if package can be installed
    system '#' # Should contain something like, "'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'"
  end

  def self.postinstall # For post-install messages or operations, not required
    system '#'
  end

  def self.remove # For package extra remove operations if needed, not required
    system '#'
  end
end
```

***
# Footnotes

<a name="Arch">**Arch**</a>: Chromebrew packages for `x86_64`, `i686`, `armv7l`, and `aarch64`.

<a name="More">**More**</a>: Must come from an official source, not a distro's source archive. Should contain the version number<sup>(Which must be equal to the version variable)</sup> `https` is preferred over `http` or `ftp` - When possible.

NOTE: All rules can have exceptions, if ***REQUIRED***, exceptions to the rules should be avoided at all costs.

<a name="eq">`CREW_OPTIONS`</a>: Equal to `--prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --mandir=#{CREW_MAN_PREFIX} --build=#{CREW_BUILD} --host=#{CREW_TGT} --target=#{CREW_TGT} --program-prefix='' --program-suffix=''`

Any additionally required resources for ChromeOS or Chromebooks can be found [here](https://github.com/chromebrew/chromebrew/wiki/Links)

Still can't find something? Have a look in [`Issues`](https://github.com/chromebrew/chromebrew/issues)<sup>Or post a issue</sup>

This Manual is heavily based off <a hrel="https://github.com/void-linux/void-packages/blob/master/Manual.md"><code>void-packages/Manual.md</code></a>
