# xorg-cf-files: Build a bottle for Linuxbrew
class XorgCfFiles < Formula
  desc "X.Org Utilities: xorg-cf-files"
  homepage "http://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url    "https://www.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "https://www.x.org/archive/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  mirror "http://ftp.x.org/pub/individual/util/xorg-cf-files-1.0.6.tar.bz2"
  sha256 "4dcf5a9dbe3c6ecb9d2dd05e629b3d373eae9ba12d13942df87107fdc1b3934d"
  # tag "linuxbrew"

  depends_on "pkg-config" => :build
  depends_on "font-util"  => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
