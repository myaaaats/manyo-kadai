# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')

    visit tasks_path

    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in "task[title]", with: "タスク名"
    fill_in "task[content]", with: "タスクの内容"
    click_button 'Create Task'

    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
    click_button 'Create Task'
  end

  scenario "タスク詳細のテスト" do
    visit new_task_path
    fill_in "task[title]", with: "タスク名"
    fill_in "task[content]", with: "タスクの内容"
    click_button 'Create Task'

    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
    click_button 'Create Task'

    visit tasks_path
    click_link '詳細'
    expect(page).to have_content 'タスク名'
    expect(page).to have_content 'タスクの内容'
  end
end
