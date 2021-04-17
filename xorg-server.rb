class XorgServer < Formula
  desc "X.Org Server"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive//individual/xserver/xorg-server-1.19.3.tar.bz2"
  mirror "https://ftp.x.org/pub/individual/xserver/xorg-server-1.19.3.tar.bz2"
  sha256 "677a8166e03474719238dfe396ce673c4234735464d6dadf2959b600d20e5a98"
  # tag "linuxbrew"

  option "with-test", "Skip compile-time tests"
  option "without-libepoxy", "Build without libepoxy and glamour"

  depends_on "pkg-config" => :build
  depends_on "glibc" => :build
  depends_on "linuxbrew/xorg/mesa"
  depends_on "libepoxy" => :recommended
  depends_on "libunwind"
  depends_on "openssl"
  depends_on "pixman"
  depends_on "linuxbrew/xorg/xorg-fonts"
  depends_on "linuxbrew/xorg/libxfont2"
  depends_on "linuxbrew/xorg/xkeyboardconfig"
  depends_on "linuxbrew/xorg/xcb-util-keysyms" => :recommended
  depends_on "linuxbrew/xorg/wayland-protocols" => :recommended
  depends_on "linuxbrew/xorg/wayland" => :recommended
  depends_on "linuxbrew/xorg/libxshmfence"
  depends_on "linuxbrew/xorg/libxdamage"
  depends_on "libgcrypt"

  if build.with? "docs"
    depends_on "fop" => :build
    depends_on "linuxbrew/xorg/xorg-sgml-doctools"
  end

  # Enable PRIME support
  # About PRIME: https://devtalk.nvidia.com/default/topic/957814/linux/prime-and-prime-synchronization/
  resource "prime" do
    url "http://www.linuxfromscratch.org/patches/blfs/svn/xorg-server-1.19.3-add_prime_support-1.patch"
    sha256 "507fa5852527c0ff418a4c168fea9476325e7c6ca1d0dd6a67cf0990727428ea"
  end

  def install
    buildpath.install resource("prime")
    system "patch", "-p1", "-i", "xorg-server-1.19.3-add_prime_support-1.patch"

    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-suid-wrapper
      --disable-systemd-logind
      --with-sha1=libgcrypt
    ]
    args << "--enable-glamor" if build.with? "libepoxy"
    args << "--enable-xwayland" if build.with? "wayland"
    args << "--enable-kdrive"
    # --disable-systemd-logind
    # --enable-install-setuid

    system "./configure", *args
    system "make"
    if build.with? "test"
      touch Formula["glibc"].bin/".."/etc/"ld.so.conf"
      system "ldconfig"
      system "make", "check"
    end
    system "make", "install"
    (etc/"X11/xorg.conf.d").mkdir unless File.exist?(etc/"X11/xorg.conf.d")

    rm etc/"sysconfig/createfiles" if File.exist? etc/"sysconfig/createfiles"
    (etc/"sysconfig/createfiles").write <<-EOF.undent
     #{etc}/tmp/.ICE-unix dir 1777 #{ENV["USER"]} #{ENV["USER"]}
     #{etc}/tmp/.X11-unix dir 1777 #{ENV["USER"]} #{ENV["USER"]}
     EOF
  end

  test do
    assert File.exist?(bin/"Xorg")
  end
end
