require 'formula'

class SaneBackendsDev < Formula
  homepage 'http://www.sane-project.org/'
  url 'http://anonscm.debian.org/gitweb/?p=sane/sane-backends.git;a=snapshot;h=0fbe145706b954d5aede360c4c9e703e6178212e;sf=tgz'
  sha256 'ad392da514e11da017b572edf2f910df49e86c8ee890267e49f2902d1d991681'

  # option :universal
  bottle do
    root_url 'http://content.merqlove.ru/bottles'
    sha256 'c3feb00518297576af62fbb3dad207363f046d61d7f971d66d7f98f166e37a9e' => :mountain_lion
    sha256 '3d732c3c05207ad1406f0c740c2c9ccafb6137468f114c6d60787f3f1cba217e' => :mavericks
  end

  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'libusb-compat'

  skip_clean :la

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
