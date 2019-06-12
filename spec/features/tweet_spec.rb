require 'rails_helper'

feature 'tweet', type: :feature do
  let(:user) { create(:user) }

  scenario 'post tweet' do
    # 未ログインの状態
    visit root_path
    expect(page).to have_no_content('投稿する')  # 投稿するボタンが表示されないようになっているかどうか

    # ログイン処理
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find('input[name="commit"]').click    # ログインボタンをクリックする処理
    expect(current_path).to eq root_path   # ログイン後にリダイレクトするページがroot_pathかどうか
    expect(page).to have_content('投稿する')  # 投稿ボタンが表示されているかどうか

    # ツイートの投稿
    expect {
      click_link('投稿する')
      expect(current_path).to eq new_tweet_path
      fill_in 'image', with: 'https://s.eximg.jp/expub/feed/Papimami/2016/Papimami_83279/Papimami_83279_1.png'
      fill_in 'text', with: 'フィーチャスペックのテスト'
      find('input[type="submit"]').click
    }.to change(Tweet, :count).by(1)

  end
end