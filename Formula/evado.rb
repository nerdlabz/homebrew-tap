class Evado < Formula
  desc "Terminal client for Evado todos"
  homepage "https://evado.app"
  license "MIT"

  on_macos do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.1.0/evado_1.1.0_darwin_arm64.tar.gz"
      sha256 "d2e631162661fd31ad61a580c1c38328dd0e37e9616b5fcc075758718f62739b"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.1.0/evado_1.1.0_darwin_amd64.tar.gz"
      sha256 "9620e84c716d252a61b51a7319ae8658bf7674035ea044ad6052de2379af73d5"
    end
  end

  on_linux do
    on_arm do
      depends_on arch: :arm64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.1.0/evado_1.1.0_linux_arm64.tar.gz"
      sha256 "cee70cc7eb619fedb73725be6758272e1c66047eea0073da88d6740a414d0c0c"
    end
    on_intel do
      depends_on arch: :x86_64
      url "https://github.com/nerdlabz/evado-tui/releases/download/v1.1.0/evado_1.1.0_linux_amd64.tar.gz"
      sha256 "a23c8d0dd46ec66866fc0ee018cbb5bdd5c6b9f9a178aed6a3febeeb49e39d51"
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
