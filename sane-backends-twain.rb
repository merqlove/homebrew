require 'formula'

class SaneBackendsTwain < Formula
  homepage 'http://www.sane-project.org/'
  url 'http://fossies.org/linux/misc/sane-backends-1.0.24.tar.gz'
  sha256 '835bef7738ea3e94a32fc7b55881a86db57f94a3d325d7bbf248eb3a9ab8cfc9'

  option :universal

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusbx'

  # Fixes u_long missing error. Reported upstream:
  # https://github.com/fab1an/homebrew/commit/2a716f1a2b07705aa891e2c7fbb5148506aa5a01
  # When updating this formula, check on the usptream status of this patch.
  def patches
    DATA
  end

  def install
    ENV.universal_binary if build.universal?
    ENV.j1 # Makefile does not seem to be parallel-safe
    system "./configure", #"--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          #"--without-gphoto2",
                          #"--enable-local-backends",
                          "--enable-libusb"
                          #"--disable-latex"
    system "make"
    system "make install"

    # Some drivers require a lockfile
    (var+"lock/sane").mkpath
  end
end

__END__
diff --git a/include/sane/sane.h.orig b/include/sane/sane.h
index 5320b4a..6cb7090 100644
--- a/include/sane/sane.h.orig
+++ b/include/sane/sane.h
@@ -20,6 +20,9 @@
 extern "C" {
 #endif
 
+// Fixes u_long missing error
+#include <sys/types.h>
+
 /*
  * SANE types and defines
  */
