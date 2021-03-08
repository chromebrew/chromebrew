
***

# Purpose

The purpose of this manual is to properly document the crew command with a rundown of function and/or variable usage. Note that this manual does not include documentation of ruby functions and variables. A basic understanding of ruby, shell and Linux is a prerequisite for package development.
> `#`'s are used as placeholders/wild-cards within this Manual.

***

## Crew
Chromebrew is a third-party package manager that interacts with ChromeOS using the `shell` and `ruby` programming languages. The `crew` command provided by Chromebrew implements a simple means to install and maintain packages native to the operating system using scripts found in `/usr/local/lib/crew/packages`. Each script contains the instructions to build and install a package. The `crew` command can also be used to update and remove packages.
***
# Build lifecycle
The crew build life-cycle consists of the stages as follows:

1. `fetch` - During the fetch phase `crew` uses `curl --ssl`  to fetch the package
2. `extract` - Once the the package has been fetched, `crew` extracts the package
3. `self.prebuild` - Ony `sed` commands should be run during this stage - if provided
    - During this stage `crew` `cd`'s into the extracted directory, and stays there until the `preinstall` stage
3. `self.patch` - Only `patch` commands should be used during this stage	- If provided
4. `self.build` - Package is compiled and/or configured
5. `self.check` - Package is then checked - If provided
6. `self.preinstall` - Pre-install checks/edits are done - If provided
7. `self.install` - Commands to install to `#{CREW_DEST_DIR}` are run
	- ONLY required function
8. `self.postinstall` - Post-install checks/edits are done - If provided
9. Package
	 - Only binary packages call this stage
		 - Contents are checked and packaged, then installed to `#{CREW_PREFIX}`
***
## Binary
Binary packages follow a different set of rules then source packages.
> `crew build` is used to build binaries
Only the functions `self.preinstall` and `self.postinstall` are run during a binary package install.
`crew` requires a few things to exist in the archive in order to install a binary package.

- `dlist` a list of directories used/installed to by the package
- `filelist` a list of all files included in the package
***
## Variables

The required package variables are as follows: - [Rundown](#rundown)

- `class # < Package` - The`#` must be name of the name of your package	. It must start with a capital and be the same as the filename. (`#.rb`)
- `description`  - Is the description of the package.
- `homepage`  - Is the homepage of the package.
- `version`  - Is the package version.
- `compatibility`  - Which architectures the package can operate on.
- `source_url`  Is the URL where the source package can be found.<sup>[More](#More)</sup>
- `source_sha256`  - The checksum for the package which will be downloaded from the `source_url`.
### Preset Constants

Preset constants are shown below:
> Most of these constants can displayed using the `crew const` command


- `#{CREW_PREFIX}` - The prefix used by `crew` - Equal to `/usr/local`
- `#{CREW_LIB_PREFIX}` - The `LIB` prefix used by `crew` - Equal to `#{CREW_PREFIX}/lib` - `#{CREW_PREFIX}/lib64` on `amd64`
- `#{CREW_DEST_DIR}` - The`DESTDIR` variable used by `crew` - Equal to `#{CREW_PREFIX}/tmp/crew/dest`
- `#{CREW_DEST_PREFIX}` - The`DESTDIR` variable prefix used by `crew` - Equal to `#{CREW_DEST_DIR}/usr/local`
- `#{CREW_OPTIONS}` - The preset options for `./congifure` - <sup>[Equals](#eq)</sup>
- `#{CREW_MAN_PREFIX}` - Useful for building man pages - Equal to `#{CREW_PREFIX}/share/man`
- `#{CREW_DEST_LIB_PREFIX}` - The `DESTDIR` `LIB` prefix - Equal to `#{CREW_DEST_PREFIX}/lib` - `#{CREW_DEST_PREFIX}/lib64` on `amd64`
- `#{CREW_DEST_HOME}` - The `DESTDIR` home variable - Equal to `#{CREW_DEST}/#{HOME}`
- `#{HOME}` - Variable used by `crew` for `$HOME`
- `#{ARCH}` - Variable used by `crew` for `$(arch)`
- `#{CREW_NPROC}` - Variable used by `crew` for `$(nproc)`


***

## Functions

Required functions are as follows: - [Rundown](#rundown)

- `def self.build` - Contains commands used to build/compile the software.
- `def self.install` - Should be used for `# install` but is not required to be defined. - [Rundown]

> #### Additional Functions

Optional functions are as follows:

- `self.prebuild` - Can be used to define functions<sup>(Or commands)</sup> that should be used to edit various files.
- `def self.patch` - Can be used to define functions<sup>(Or commands)</sup> that should be used to `patch` various files.
- `def self.preinstall` - Can be used to define functions<sup>(Or commands)</sup> that should happen `pre`-install.
- `def self.check` - Can be used to define functions<sup>(Or commands)</sup> that should be used to check the compile binary.
- `def self.postinstall` - Can be used to define functions<sup>(Or commands)</sup> that should happen `post`-install.
- `is_fake` - Cane be used to label package as meta.
***
# Rundown

The rundown of what each function and variable are/(can be) used for follows.

A simple example ruby script can be found on the [Wiki](https://github.com/skycocker/chromebrew/wiki/Creating-a-package).
```ruby
require 'package' # must occour within each `.rb`
			      # Notice the newline
class Template < Package # Notice the capitals, EG: 'I3' - would be used for an 'i3' package
  description 'The template script' # Notice the indent, should contain no more than one line of text
  homepage '#' # Notice the same indent, EG: 'https://i3wm.org/' - Would be used for an 'i3' Package
  version 'version#-revision#' # EG: 4.18.2-1 - Where '4.18.2' is the version and '1' is the revision - Omit revision on new packges
  compatibility '#' # Can contain 'all', or a list of supported architectures each seperated by a space
  source_url '#' # The URL from which the source of the package can be downloaded
  source_sha256 '#' # The `sha256` checksum of the downloaded source package
                  # Notice the newline
  depends_on '#' # Soft where this package depends on
  depends_on '#' => :build # Only required when the package
  is built from source
            # Notice the newline
  def self.preflight # For preflight checks, not required
    system '#'  # Replace '#' with a disk space check, for example
  end
  def self.prebuild # For sed operations, not required
    system '#'  # Replace '#' with a sed operation
  end
  def self.patch # For patch operations, not required
    system '#' # Replace '#' with a patch operation
  end

  def self.build # Contains the commands which compile the package, required if package con be compiled
    system '#' # Replace '#' with commands to compile the package
    system '#' # Should contain something like, "./configure --prefix=/usr/local"
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
end
```
<!-- self.prebuild is not included yet -->

***
# Footnotes

<a name="Arch">**Arch**</a>: Chromebrew packages for `x86_64`, `i686`, `armv7l`, and `aarch64`.

<a name="More">**More**</a>: Must come from an official source, not a distro's source archive. Should contain the version number<sup>(Which must be equal to the version variable)</sup> `https` is preferred over `http` or `ftp` - When possible.

NOTE: All rules can have exceptions, if ***REQUIRED***, exceptions to the rules should be avoided at all costs.

<a name="eq">`CREW_OPTIONS`</a>: Equal to `--prefix=/usr/local --libdir=/usr/local/lib --mandir=/usr/local/share/man --build=armv7l-cros-linux-gnueabihf --host=armv7l-cros-linux-gnueabihf --target=#{CREW_BUILD}`

Any additonally required resources for ChromeOS or ChromeBooks cane be found [here](https://github.com/skycocker/chromebrew/wiki/Links)

Still can't find something? Have a look in [`Issues`](https://github.com/skycocker/chromebrew/issues)<sup>Or post a issue</sup>

This Manual is heavily based off <a hrel="https://github.com/void-linux/void-packages/blob/master/Manual.md"><code>void-packages/Manual.md</code></a>

