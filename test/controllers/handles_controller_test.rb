# frozen_string_literal: true

require 'test_helper'

class HandlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @handle = handles(:one)
  end

  test 'should get index' do
    get handles_url
    assert_response :success
  end

  test 'should get new' do
    get new_handle_url
    assert_response :success
  end

  test 'should create handle' do
    assert_difference('Handle.count') do
      post handles_url, params: {
        handle: {
          description: @handle.description, notes: @handle.notes,
          prefix: @handle.prefix, repo: @handle.repo, repo_id: @handle.repo_id,
          url: @handle.url
        }
      }
    end

    assert_redirected_to handle_url(Handle.last)
  end

  test 'should show handle' do
    get handle_url(@handle)
    assert_response :success
  end

  test 'should get edit' do
    get edit_handle_url(@handle)
    assert_response :success
  end

  test 'should update handle' do
    patch handle_url(@handle), params: {
      handle: {
        description: @handle.description, notes: @handle.notes,
        repo: @handle.repo, repo_id: @handle.repo_id,
        suffix: @handle.suffix, url: @handle.url
      }
    }
    assert_redirected_to handle_url(@handle)
  end

  test 'should not be able to update prefix of handle' do
    original_prefix = @handle.prefix
    new_prefix = 'some_other_prefix'
    assert_not_equal original_prefix, new_prefix

    patch handle_url(@handle), params: {
      handle: {
        prefix: new_prefix
      }
    }

    @handle.reload
    assert_equal original_prefix, @handle.prefix
    assert_redirected_to handle_url(@handle)
  end

  test 'should not be able to update suffix of handle' do
    original_suffix = @handle.suffix
    new_suffix = Handle.group(:prefix).maximum(:suffix)[@handle.prefix] + 1
    assert_not_equal original_suffix, new_suffix

    patch handle_url(@handle), params: {
      handle: {
        suffix: new_suffix
      }
    }

    @handle.reload
    assert_equal original_suffix, @handle.suffix
    assert_redirected_to handle_url(@handle)
  end

  test 'should destroy handle' do
    assert_difference('Handle.count', -1) do
      delete handle_url(@handle)
    end

    assert_redirected_to handles_url
  end
end
