require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.create(title: "テスト", content: "")
    expect(task).not_to be_valid
  end

  it "titleもcontentも空ならバリデーションが通らない" do
    task = Task.create(title: "", content: "")
    expect(task).not_to be_valid
  end

  it "titleが20文字以上ならバリデーションが通らない" do
    title = "title" * 4
    task = Task.create(title: "#{title}", content: "content")
    expect(task).not_to be_invalid
  end

  it "contentが200文字以上ならバリデーションが通らない" do
    content = "content___" * 20
    task = Task.create(title: "title", content: "#{content}")
    expect(task).not_to be_invalid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.create(title: "うまくいくタイトル", content: "うまくいくコンテント")
    expect(task).to be_valid
  end
end
