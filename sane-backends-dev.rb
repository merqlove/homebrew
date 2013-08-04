require 'formula'

class SaneBackendsDev < Formula
  homepage 'http://www.sane-project.org/'
  url 'https://www.dropbox.com/sh/26miq420ssd1sww/Z_VeHxdk9r'
  sha1 '86777cdbd3c382ee913a8f7f8f0cff5bd8dff1a2'

  # option :universal
  bottle do
    # sha1 'f4307ebd1fe094dbd14e4e19c717baa83bdd9631' => :snow_leopard
    # sha1 '45d35923b0439617adb86630bdd4985a6cf03984' => :lion
    sha1 'a0eb40e1fbf29651949c9baa530c34e7bef769f4' => :mountain_lion
  end

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb-compat'

  # Fixes u_long missing error. Reported upstream:
  # https://github.com/fab1an/homebrew/commit/2a716f1a2b07705aa891e2c7fbb5148506aa5a01
  # When updating this formula, check on the usptream status of this patch.
  def patches
    DATA
  end

  def install
    ENV.universal_binary if build.universal?
    ENV.j1 # Makefile does not seem to be parallel-safe
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--without-gphoto2",
                          "--enable-local-backends",
                          "--enable-libusb",
                          "--disable-latex"
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
