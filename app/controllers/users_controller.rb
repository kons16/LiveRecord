class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, 
                        :following, :followers]
    before_action :correct_user,   only: [:edit, :update, :add]

    # マイページにアクセス
    def show
        @user = User.find(params[:id])
        @archive_year = params[:archive_year]
        @artist_select = params[:artist_select]
        @place_select = params[:place_select]
        @type = params[:type]
        @microposts =  @user.microposts.paginate(:page => params[:page], :per_page => 6)

        # アーカイブとチケットの種類を選択
        if @archive_year.present? and @type.present?
            @microposts = @microposts.where(year: @archive_year)

            if @type == "live"
                @microposts = @microposts.where(teama: "")
            elsif @type == "sport"
                @microposts = @microposts.where.not(teama: "")
            end
        end

        # アーカイブ選択
        if @archive_year.present?
            @microposts = @microposts.where(year: @archive_year)
        end

        # アーティスト選択
        if @artist_select.present?
            @microposts = @microposts.where(artist: @artist_select)
        end

        # 会場選択
        if @place_select.present?
            @microposts = @microposts.where(place: @place_select)
        end

        # チケットの種類選択
        if @type.present?
            if @type == "live"
                @microposts = @microposts.where(teama: "")
            elsif @type == "sport"
                @microposts = @microposts.where.not(teama: "")
            end
        end

        # アーティスト別回数
        @artists = []
        @cnt_artist = []
        @artists = @user.microposts.where(teama: '').pluck(:artist).uniq    # スポーツではないチケットのアーティストを取得
        @artists.each {
            |artist| @cnt_artist.push(@user.microposts.where(artist: artist).count) 
        }
        a = [@artists, @cnt_artist].transpose
        @ah = Hash[*a.flatten]
        @ah = Hash[@ah.sort_by{ |_, v| -v } ]

        # 会場別回数
        @places = []
        @cnt_place = []
        @places = @user.microposts.pluck(:place).uniq
        @places.each { |place| 
            @cnt_place.push(@user.microposts.where(place: place).count)
        }
        pa = [@places, @cnt_place].transpose
        @ph = Hash[*pa.flatten]
        @ph = Hash[@ph.sort_by{ |_, v| -v } ]

        # アーカイブ
        @years = []
        @cnt_year = []      # その年度に追加したチケットの枚数
        @cnt_allyear = []   # 全チケット数
        @years = @user.microposts.pluck(:year).uniq.sort!.reverse!  # 重複年を削除し降順にソート
        @years.each { |year| 
            @cnt_year.push(@user.microposts.where(year: year).count)
        }
        @cnt_allyear = @user.microposts.count

        # 並び替え
        @microposts = @microposts.order(year: "DESC").order(month: "DESC").order(day: "DESC")

    end

    # ユーザ検索
    def index
        @search_kekka = params[:search]

        if @search_kekka != ''
            @users = User.search(@search_kekka)
        else # 未入力で検索したとき
            @users = []
        end
    end

    def following
        @user  = User.find(params[:id])
        @users = @user.following.paginate(page: params[:page])
        render 'show_follow'
    end

    def followers
        @user  = User.find(params[:id])
        @users = @user.followers.paginate(page: params[:page])
        render 'show_follower'
    end

    private

        # 正しいユーザーかどうかを確認
        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_url) unless @user == current_user
        end

end
