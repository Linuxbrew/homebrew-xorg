class Xorg < Formula
  desc "X.Org X11 libraries"
  homepage "https://www.x.org/"
  ### http://www.linuxfromscratch.org/blfs/view/svn/x/x7lib.html
  url "https://raw.githubusercontent.com/Linuxbrew/homebrew-xorg/317ef5e60c62298a28f08bb44ca6a09d79793735/README.md"
  version "20170115"
  sha256 "76b4fd623d6b10d816069aedcffc411e2c9abc607533adf3fa810d7904b5f9d1"
  revision 1
  # tag "linuxbrew"

  livecheck do
    skip "Formula only installs other formulae"
  end

  bottle :unneeded

  option "with-docs", "Build documentation and specifications (where applicable)"
  option "without-test", "Skip compile-time tests"

  # Build a list of requested compile flags for formulas
  args_docs = build.with?("docs") ? "with-docs" : ""
  args_devel_docs = build.with?("docs") ? "with-devel-docs" : ""
  args_specs = build.with?("docs") ? "with-specs" : ""
  args_check = build.without?("test") ? "without-test" : ""

  depends_on "linuxbrew/xorg/libdmx" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libfontenc" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libfs" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libice" => [args_check, args_docs, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libpciaccess" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libpthread-stubs"
  depends_on "linuxbrew/xorg/libsm" => [args_check, args_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libx11" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxaw" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxaw3d" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxcomposite" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxcursor" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxdamage" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxext" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxfixes" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxfont" => [args_check, args_devel_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxft" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxi" => [args_check, args_docs, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxinerama" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxkbfile" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxmu" => [args_check, args_docs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxpm" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxrandr" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxrender" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxres" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxscrnsaver" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxshmfence" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxt" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxtst" => [args_check, args_specs].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxv" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxvmc" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxxf86dga" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/libxxf86vm" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/xdpyinfo" => [args_check].reject(&:empty?)
  depends_on "linuxbrew/xorg/xtrans" => [args_docs].reject(&:empty?)
  # libpthread-stubs is needed by a lot of formulae at build time (pango, cairo, ...)

  if build.with?("docs") # or build.with?("specs")
    depends_on "linuxbrew/xorg/xorg-docs" => :recommended
    # xorg-docs is not a part of Xorg Libraries.
    # We build it by default when documentation / specifications are requested

    ### Provide a way to override default options for the packages.
    ### These options will be later combined into args_extra variable
    ### and passed to formulas that accept them
    # option "without-fop", "Build without fop support"
    # option "without-libxslt", "Build without libxslt support"
    # option "without-xorg-sgml-doctools", "Build without xorg-sgml-doctools support"
    # ###
  end

  def install
    ohai "X.Org has been installed!"
    prefix.install "README.md" => "xorg.md"
  end
end
