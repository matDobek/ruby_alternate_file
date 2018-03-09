require "test/unit"

require "./alternate_file"

class TestAlternateFile < Test::Unit::TestCase
  def class_under_test
    AlternateFile
  end

  def test_new___raises_exception___when_unsupported_argument
    assert_raises ArgumentError do
      class_under_test.new(orginal_file_path: nil, alternate_dir_mapping: {})
    end
  end

  def test_new___raises_exception___when_unsupported_dir
    assert_raises ArgumentError do
      class_under_test.new(
        orginal_file_path: "/unsupported/sample.rb",
        alternate_dir_mapping: { "app" => "/test/" },
      )
    end
  end

  def test_new___raises_exception___when_supported_dir_is_subname
    assert_raises ArgumentError do
      class_under_test.new(
        orginal_file_path: "/unsupported_app/sample.rb",
        alternate_dir_mapping: { "app" => "/test/" },
      )
    end
  end

  def test_directory___returns_alternate_string___when_supported_path
    object_under_test = class_under_test.new(
      orginal_file_path: "/app/service/sample.rb",
      alternate_dir_mapping: { "app" => "/test/" },
    )
    result = object_under_test.directory

    assert_equal("/test/service", result)
  end

  def test_filename_with_ext___returns_alternate_string___when_supported_path
    object_under_test = class_under_test.new(
      orginal_file_path: "/app/service/sample.rb",
      alternate_dir_mapping: { "app" => "/test/" },
    )
    result = object_under_test.filename_with_ext

    assert_equal("sample_test.rb", result)
  end
end
