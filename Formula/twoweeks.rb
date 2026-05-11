class Twoweeks < Formula
  desc "Time the gap between your AI's confident estimate and your actual ship time"
  homepage "https://github.com/Meliwat/twoweeks"
  url "https://github.com/Meliwat/twoweeks/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "f665e2eaf5f0420a2ff05b9f3427a31b9fb14ee0a3f426f5053a4fdb1b25ae25"
  license "MIT"
  head "https://github.com/Meliwat/twoweeks.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", "--omit=dev", "--ignore-scripts"
    libexec.install "dist", "node_modules", "package.json", "assets"
    (bin/"twoweeks").write <<~SHIM
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/cli.js" "$@"
    SHIM
    chmod 0755, bin/"twoweeks"
  end

  test do
    assert_match "twoweeks v0.7", shell_output("#{bin}/twoweeks --version")
    ENV["TWOWEEKS_HOME"] = testpath/".twoweeks"
    system bin/"twoweeks", "smoke test", "2 weeks"
    assert_match "SHIPPED", shell_output("#{bin}/twoweeks ship --no-color")
  end
end
