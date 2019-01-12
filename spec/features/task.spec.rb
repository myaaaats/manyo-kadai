# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do

    visit tasks_path

    expect(page).to have_content 'test1test1test1'
    expect(page).to have_content 'test2test2test2'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    # タスクが作成日時の降順に並んでいるかのテスト
    click_link '詳細', match: :first
    expect(page).to have_content 'test2test2test2'

  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "task[title]", with: "タスク名"
    fill_in "task[content]", with: "タスクの内容"
    click_button '登録する'

    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
    click_button '登録する'
  end

  scenario "タスク詳細のテスト" do
    visit new_task_path
    fill_in "task[title]", with: "タスク名"
    fill_in "task[content]", with: "タスクの内容"
    click_button '登録する'

    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
    click_button '登録する'

    visit tasks_path
    click_link '詳細', match: :first
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
  end
end
