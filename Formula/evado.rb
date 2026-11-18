class Evado < Formula
  desc "Terminal client for Evado todos"
  homepage "https://evado.app"
  license "MIT"

  on_macos do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.0/evado_1.0.0_darwin_arm64.tar.gz"
      sha256 "9f94802d9d2a9cfe37501f519a2bf8456cbade43e1e54d9ba29aea4268b6b1e5"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.0/evado_1.0.0_darwin_amd64.tar.gz"
      sha256 "8491542815583853c84f7a666b41c05dbea00c88d288627197ec8018ce9a260a"
    end
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.0/evado_1.0.0_linux_arm64.tar.gz"
      sha256 "3b223be0733f86154226ee039175b5ba35263ce50d90a666502550215adeb5c8"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.0.0/evado_1.0.0_linux_amd64.tar.gz"
      sha256 "c1e4b6ed1a22b0a52b42e0c2909fb3786acbe81a4498dd380de6fb25c0a9057a"
    end
  end

  def install
    bin.install "evado"
    pkgshare.install "THIRD_PARTY_NOTICES.txt"
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
  end

  test do
    assert_equal "evado #{version}", shell_output("#{bin}/evado -version").strip

    ENV["EVADO_CONFIG"] = (testpath/"profile/config.json").to_s
    added = JSON.parse(shell_output("#{bin}/evado -local add -json 'Homebrew formula test'"))
    todo = added.fetch("todos").fetch(0)
    assert_equal "Homebrew formula test", todo.fetch("title")

    listed = JSON.parse(shell_output("#{bin}/evado -local ls -json"))
    assert_equal [todo.fetch("id")], listed.fetch("todos").map { |item| item.fetch("id") }
  end
end
