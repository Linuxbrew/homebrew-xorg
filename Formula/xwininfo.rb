class Xwininfo < Formula
  desc "X.Org Applications: xwininfo"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7app.html
  url "https://www.x.org/pub/individual/app/xwininfo-1.1.5.tar.bz2"
  sha256 "7a405441dfc476666c744f5fcd1bc8a75abf8b5b1d85db7b88b370982365080e"
  revision 2
  # tag "linuxbrew"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-xorg"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0284db072c27f2511421defa2c24dbbfb5e4be0f7524c90b446b4cb901eac762"
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "xcb-util-wm"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --with-xcb-icccm
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end
end
