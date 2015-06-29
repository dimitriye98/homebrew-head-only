class Glxw < Formula
  desc     "OpenGL loader and dynamic linker"
  homepage "https://github.com/rikusalminen/glxw"
  head     "https://github.com/rikusalminen/glxw.git"

  depends_on :python => :build if MacOS.version <= :snow_leopard

  def install
    system "./glxw_gen.py", "--output", prefix
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <GLXW/glxw.h>
      int main()
      {
        if (glxwInit() != 0) return 1;
        return 0;
      }
    EOS
    src = File.join prefix, "src"
    system ENV.cc, "test.c", "-I#{include}", "-L#{src}", "-F/System/Library/Frameworks", "-framework", "Carbon", File.join(src, "gl3w.c"), "-o", "test"
    system "./test"
  end
end
