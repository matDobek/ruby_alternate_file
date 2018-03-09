# frozen_string_literal: true

class AlternateFile
  def initialize(orginal_file_path:, alternate_dir_mapping:)
    @orginal_file_path     = orginal_file_path
    @alternate_dir_mapping = alternate_dir_mapping

    fail ArgumentError if path_not_supported?
  end

  def directory
    orginal_dir_path.gsub("/#{supported_directory}/", fetch_alternate_directory)
  end

  def filename_with_ext
    "#{orginal_filename}_test.#{orginal_ext}"
  end

  private

  attr_reader :orginal_file_path, :alternate_dir_mapping

  def path_not_supported?
    !orginal_file_path.is_a?(String) ||
      supported_directory.empty?
  end

  def orginal_dir_path
    orginal_file_path.split("/")[0..-2].join("/")
  end

  def orginal_filename_with_ext
    orginal_file_path.split("/").last
  end

  def orginal_filename
    orginal_filename_with_ext.split(".").first
  end

  def orginal_ext
    orginal_filename_with_ext.split(".").last
  end

  def supported_directory
    @supported_directory ||= String(fetch_supported_directory)
  end

  def fetch_supported_directory
    supported_directories.find { |d| orginal_file_path.include?("/#{d}/") }
  end

  def supported_directories
    @supported_directories ||= Array(fetch_supported_directories)
  end

  def fetch_supported_directories
    alternate_dir_mapping.keys
  end

  def fetch_alternate_directory
    alternate_dir_mapping.fetch(supported_directory)
  end
end
