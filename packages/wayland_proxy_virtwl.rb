require 'package'

class Wayland_proxy_virtwl < Package
  description 'Proxy Wayland connections across the VM boundary'
  homepage 'https://github.com/talex5/wayland-proxy-virtwl'
  @_ver = '69de5648bad98a0f7ae19bea292420d7fd804205'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/talex5/wayland-proxy-virtwl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-3_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-3_armv7l/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-3_i686/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wayland_proxy_virtwl/5b576d5cad76de6ed7513cc85748efd78ca366cf-3_x86_64/wayland_proxy_virtwl-5b576d5cad76de6ed7513cc85748efd78ca366cf-3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2172ba0d35a4a9eedc95a656de158eb08eea91319d5f2fa026a56c6bbeece71f',
     armv7l: '2172ba0d35a4a9eedc95a656de158eb08eea91319d5f2fa026a56c6bbeece71f',
       i686: 'a8d9f3080c89d7fffa92b4198d47a49a981938ec974f08b287153e27ab0d545e',
     x86_64: 'cd041ee4a63ec0f540e3820553d12e9e0d933de103eede6a6a97026bcf12363a'
  })

  depends_on 'ocaml' => :build
  depends_on 'opam' => :build
  depends_on 'xwayland'

  @OPAMROOT = "#{CREW_PREFIX}/share/opam"

  def self.patch
    @xwayland_patch = <<~'PATCH_XWAYLAND_EOF'
      --- a/wayland-proxy-virtwl/xwayland.ml     2021-11-18 20:34:27.000000000 +0000
      +++ b/wayland-proxy-virtwl/xwayland.ml     2021-11-24 19:27:16.940505733 +0000
      @@ -129,9 +129,7 @@ module Selection = struct
           x11 : X11.Display.t Lwt.t;
           wayland_primary_offer : [`V1] Primary_offer.t option ref;
           wayland_clipboard_offer : [`V1|`V2|`V3] Clipboard_offer.t option ref;
      -    primary_selection_mgr : [`V1] Primary_mgr.t;
           clipboard_mgr : [`V1] Clipboard_mgr.t;
      -    primary_device : [`V1] Primary_device.t;
           clipboard_device : [`V1] Clipboard_device.t;
           selection_window : X11.Window.t Lwt.t;
           set_selection_window : X11.Window.t Lwt.u;
      @@ -373,23 +371,6 @@ module Selection = struct
             | None -> Lwt.return []
           in
           (* Create a Wayland source offering those targets *)
      -    let source = Primary_mgr.create_source t.primary_selection_mgr @@ object
      -        inherit [_] Primary_source.v1
      -
      -        method on_send _ ~mime_type ~fd =
      -          Log.info (fun f -> f "Sending X PRIMARY selection to Wayland (%S)" mime_type);
      -          send_x_selection t primary ~via:requestor ~mime_type ~dst:fd
      -
      -        method on_cancelled self =
      -          Log.info (fun f -> f "X selection source cancelled by Wayland - X app no longer owns selection");
      -          Lwt.async (fun () ->
      -              X11.Selection.set_owner x11 ~owner:(Some requestor) ~timestamp:`CurrentTime primary
      -            );
      -          Primary_source.destroy self
      -      end
      -    in
      -    targets |> List.iter (fun mime_type -> Primary_source.offer source ~mime_type);
      -    Primary_device.set_selection t.primary_device ~source:(Some source) ~serial:(Relay.last_serial t.relay);
           Lwt.return_unit

         (* Similar to {!set_x_owned_primary}, but for Wayland's clipboard API. *)
      @@ -478,13 +459,11 @@ module Selection = struct
             failwith "Expected exactly one X11 root window!"

         let create ~relay ~seat ~x11 ~virtwl ~registry =
      -    let primary_selection_mgr = Wayland.Registry.bind registry @@ new Primary_mgr.v1 in
           let clipboard_mgr = Wayland.Registry.bind registry @@ new Clipboard_mgr.v1 in
           let selection_window, set_selection_window = Lwt.wait () in
           let clipboard_window, set_clipboard_window = Lwt.wait () in
           let wayland_primary_offer = ref None in
           let wayland_clipboard_offer = ref None in
      -    let primary_device = Primary_mgr.get_device primary_selection_mgr ~seat @@ primary_device ~wayland_primary_offer in
           let clipboard_device = Clipboard_mgr.get_data_device clipboard_mgr ~seat @@ clipboard_device ~wayland_clipboard_offer in
           {
             x11;
      @@ -495,8 +474,6 @@ module Selection = struct
             wayland_primary_offer;
             selection_window;
             set_selection_window;
      -      primary_selection_mgr;
      -      primary_device;
             (* Clipboard: *)
             wayland_clipboard_offer;
             clipboard_window;
    PATCH_XWAYLAND_EOF
    @relay_patch = <<~'PATCH_RELAY_EOF'
      --- a/wayland-proxy-virtwl/relay.ml	2021-11-18 20:34:27.000000000 +0000
      +++ b/wayland-proxy-virtwl/relay.ml	2021-11-24 23:48:42.805651473 +0000
      @@ -466,13 +466,6 @@ let make_surface ~xwayland ~host_surface
             if x#scale <> 1l then
               H.Wl_surface.set_buffer_scale h ~scale:x#scale;       (* Xwayland will be a new enough version *)
             let set_configured s =
      -        if s = `Unmanaged then (
      -          (* For pointer cursors we want them at the normal size, even if low-res.
      -             Also, Vim tries to hide the pointer by setting a 1x1 cursor, which confuses things
      -             when unscaled. Ideally we would stop doing transforms in this case, but it doesn't
      -             seem to matter. *)
      -          H.Wl_surface.set_buffer_scale h ~scale:1l;
      -        );
               state := s;
               match data.state with
               | Ready | Destroyed -> ()
    PATCH_RELAY_EOF
    IO.write('xwayland.patch', @xwayland_patch)
    system 'patch -Np1 -i xwayland.patch'
    IO.write('xwayland.patch', @relay_patch)
    system 'patch -Np1 -i relay.patch'
  end

  def self.install
    ENV['OPAMROOT'] = @OPAMROOT
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    if (ARCH == 'armv7l') || (ARCH == 'aarch64')
      # ld.gold breaks logs 0.7.0 builds with ocaml 4.1.2
      FileUtils.cp "#{CREW_PREFIX}/bin/ld.bfd", "#{CREW_DEST_PREFIX}/bin/ld"
    end
    system "PATH=#{CREW_DEST_PREFIX}/bin:$PATH OPAMROOT=#{@OPAMROOT} opam install . --root=#{@OPAMROOT} --destdir=#{CREW_DEST_DIR}#{@OPAMROOT} -y"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/ld" if File.exist?("#{CREW_DEST_PREFIX}/bin/ld")
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../share/opam/bin/wayland-proxy-virtwl', 'wayland-proxy-virtwl'
    end
  end

  def self.postinstall
    puts <<~'EOS'.lightblue
      Note that there is not yet hardware acceleration in wayland-proxy-virtwl.
      wayland-proxy-virtwl example usage (before running a gui program):
    EOS
    puts <<~'EOSCODE'.lightcyan
      stopsommelier
      wayland-proxy-virtwl --wayland-display wayland-1 --x-display=1 --xrdb Xft.dpi:150
      export WAYLAND_DISPLAY=wayland-1
      export DISPLAY=:1
    EOSCODE
  end
end
