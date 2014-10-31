# config.plのサンプル
# デフォルトでchat.psgiと同じディレクトリのconfig.plが呼ばれる
# あるいはYANCHA_CONFIG_FILEで指定する。（暫定）

use strict;

+{
    'socketio' => { # PocketIOの設定
        'heartbeat_timeout'  => 5,  # heartbeatの間隔(heartbeat_timeout)
        'close_timeout'      => 30,  # この間通信がないとコネクションが切断される(close_timeout)
        'polling_timeout'    => 10,  # jsonp-polling, xhr-pollingにおけるpollingの有効間隔(reconnect_timeout)
        'connected_timeout'  => 30,  # handshake(connecting)してからconnectedになるまでの制限時間(connect_timeout)
        'max_connection'     => 100, # 最大同時接続数...現在のところPocketIO自体は利用していない
    },

    'server_info' => {
        version       => '1.00',
        name          => '__YANCHA_NAME__',
        default_tag   => 'PUBLIC',
        introduction  => '__YANCHA_INTRODUCTION__',
        url           => '__YANCHA_URL__',
        auth_endpoint => { # endpoint => [ $module_name, $args, $description_for_client ]
            '/login'         => [
                'Yancha::Auth::Simple'  => {
                    name_field => 'nick',
                    allow_profile_image_url_regex => '^http://pyazo.hachiojipm.org/image/'
                } => { description => 'Test!' },
            ],
            '/login/basic'   => [
                'Yancha::Auth::BasicAuth' => {
                    passwd_file  => '.htpasswd',
                    check_hashes => ['plain','crypt','md5','sha1'],
                    realm        => 'Hachioji.pm',
                } => { description => 'Basic認証' },
            ],
            '/login/twitter' => [
                'Yancha::Auth::Twitter' => {
                    consumer_key    => '__TWITTER_CONSUMER_KEY__',
                    consumer_secret => '__TWITTER_CONSUMER_SECRET__',
                }, => { description => 'Twitter!' },
            ],
        },
        api_endpoint => {
            '/api/post'    => [ 'Yancha::API::Post'   => {} => 'user message投稿用api' ],
            '/api/search'  => [ 'Yancha::API::Search' => {} => 'user message検索用api' ],
            '/api/rss'     => [ 'Yancha::API::Search' => { 'format' => 'rss' } => 'RSS取得用api' ],
            '/api/user'    => [ 'Yancha::API::User'   => {} => 'user data取得用api' ],
            '/api/tag'     => [ 'Yancha::API::Tag'    => {} => 'tag cloud取得用api' ],
        },
    },

    'database' => {
        'connect_info' => [
            'dbi:mysql:database=__MYSQL_DBNAME__;host=__MYSQL_HOST__', '__MYSQL_USER__', '__MYSQL_PASSWORD__',
            {
                mysql_enable_utf8 => 1 ,
                mysql_auto_reconnect => 1,
                RaiseError => 1,
            }
            # SQLite を使用したい場合は、上のMySQL 関連の設定を削除してから以下のコメントを解除して使用して下さい
            # 'dbi:SQLite:database=name', undef, undef, { sqlite_unicode => 1 }
        ],
	      'on_connect_exec' => 'SET NAMES utf8mb4;', # for Mysql, SQLiteの場合、コメントアウトしてください。
    },
    'message_log_limit' => 100, # タグ毎のログ数

    'token_expiration_sec' => 10, # default 604800 sec = 7 days

    'plugins' => [
        [ 'Yancha::Plugin::WelcomeMessage', [ message => 'Hi, %s. This is Hachioji.pm!' ] ],
        [ 'Yancha::Plugin::NoRec' ],
    ],


    'view' => {
        syntax => 'Kolon',
        path => [qw(view)],
        function => {
            static => sub {
                my $uri = shift;
                $uri =~ s/^\///;
                return '/static/'.$uri;
            },  
            uri => sub {
                my $uri = shift;
                $uri =~ s/^\///;
                return '/'.$uri;
            },
        },
    },
};


