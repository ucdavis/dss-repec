class FillAuthorsPapersRanks < ActiveRecord::Migration[5.2]
  def up
    Paper.ids.each do |id|
      authors_papers = Paper.find(id).authors_papers
      author_ids = authors_papers.to_a.map { |authors_paper| authors_paper.author_id }

      author_ids.each_with_index do |author_id, index|
        authors_papers.where(:author_id => author_id).update_all(rank: index + 1)
      end
    end
  end

  def down
  end
end
