import React from 'react';
var request = require('superagent');
var howler = require('howler');

export default class ChatForm extends React.Component {
    chats_url = '/apis/chats';
    my_page_url = '/apis/my_pages';
    commentNum = 30;
    fetching = false;
    next_fetch = false;
    lastChatId = 0;
    sound;
    my_page_info;

    constructor(props) {
        super(props);
        this.state = {
            inputComment: '',
            roomName: '',
            comments: [],
            users: []
        };
        this.onEnter = this.onEnter.bind(this);
        this.onChange = this.onChange.bind(this);
    }

    componentDidMount() {
        $('#comment-input').focus();
        this.soundSetting();
        this.autoFitCommentsHeight();
        this.fetchComments();
        this.setupSubscription();
    }

    onEnter(e) {
        var ENTER = 13;
        var comment = e.target.value;
        if (!e.shiftKey && e.keyCode == ENTER && comment != '') {
            this.resetInputComment();
            this.postComment(comment);
        }
    }

    onChange(e) {
        var comment = e.target.value;
        if (comment == "\n") {
            comment = '';
        }
        this.setState({
            inputComment: comment
        })
    }

    soundLoad() {
        if (this.my_page_info.sound === 'silent') return;
        var sound_path = '/sound/' + this.my_page_info.sound + '.mp3';
        this.sound = new Howl({
            src: [sound_path]
        });
        this.sound.once('load', function () {
        });
    }

    soundSetting() {
        var _this = this;
        request
            .get(this.my_page_url)
            .end(function (err, res) {
                _this.my_page_info = res.body;
                _this.soundLoad();
            });
    }

    playSound() {
        if (this.my_page_info.sound === 'silent') return;
        this.sound.play();
    }

    addComment(chat) {
        var comments = this.state.comments;
        comments.unshift(chat.view);
        if (this.commentNum < comments.length) {
            comments.splice(this.commentNum + 1);
        }
        this.setState({
            comments: comments
        });
        this.lastChatId = chat.chat.id;
    }

    fetchComments() {
        if (this.fetching) return;
        this.fetching = true;
        this.next_fetch = false;
        var _this = this;
        request
            .get(this.chats_url)
            .query({last_chat_id: this.lastChatId})
            .end(function (err, res) {
                var chats = res.body;
                chats.forEach(function (chat) {
                    _this.addComment(chat);
                });
                if (chats.length > 0) {
                    _this.playSound();
                }
                _this.fetching = false;
                if (_this.next_fetch) {
                    _this.fetchComments();
                }
            });
    }

    postComment(comment) {
        request
            .post(this.chats_url)
            .send({comment: comment})
            .end(function (err, res) {
            });
    }

    resetInputComment() {
        this.setState({
            inputComment: ''
        });
    }

    autoFitCommentsHeight() {
        var windowHeight = $(window).height();
        var minCommentsHeight = 320;
        var minusHeight = 130;
        var commentsHeight = windowHeight - minusHeight;
        if (commentsHeight < minCommentsHeight) commentsHeight = minCommentsHeight;
        console.log(windowHeight, commentsHeight);
        $('#comments').height(commentsHeight);
    }

    setupSubscription() {
        var _this = this;
        App.cable.subscriptions.create('ChatChannel', {
            received(data) {
                if (data.chat_id) {
                    _this.next_fetch = true;
                    this.fetchComments();
                }
                if (data.is_disconnect) {
                    window.location.reload();
                }
            },
            connected() {
                // console.log('connected');
                this.connect();
            },
            disconnected() {
                // console.log('disconnected');
            },
            connect() {
                this.perform('set_connected', {connect: true});
            },
            fetchComments: this.fetchComments.bind(this)
        });
    }

    render() {
        return (
            <div id="sp-chat-contents">
                <div id="comments-box">
                    <ul id="comments">
                        {this.state.comments.map((comment, idx) => {
                            return <div className="comment-wrap" key={idx}
                                        dangerouslySetInnerHTML={{__html: comment}}></div>
                        })}
                    </ul>
                </div>
                <div id="comment-form" className="field">

                        <textarea id="comment-input" onKeyDown={this.onEnter} onChange={this.onChange}
                                  value={this.state.inputComment}></textarea>
                </div>
            </div>
        )
    }

}
