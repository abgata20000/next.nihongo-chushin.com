import React from 'react'
var request = require('superagent')

export default class ChatForm extends React.Component {
    url = '/apis/chats';
    commentNum = 30;
    fetching = false;
    next_fetch = false;
    lastChatId = 0;

    constructor(props) {
        super(props);
        this.state = {
            inputComment: '',
            comments: []
        };
        this.onEnter = this.onEnter.bind(this);
        this.onChange = this.onChange.bind(this);
    }

    onEnter(e) {
        var ENTER = 13;
        var comment = e.target.value;
        if (e.keyCode == ENTER && comment != '') {
            this.resetInputComment();
            this.postComment(comment);
        }
    }

    onChange(e) {
        this.setState({
            inputComment: e.target.value
        })
    }

    componentDidMount() {
        $('#comment-input').focus();
        this.fetchComments();
        this.setupSubscription();
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
        if(this.fetching) return;
        this.fetching = true;
        this.next_fetch = false;
        var _this = this;
        request
            .get(this.url)
            .query({last_chat_id: this.lastChatId})
            .end(function (err, res) {
                var chats = res.body;
                chats.forEach(function (chat) {
                    _this.addComment(chat);
                });
                _this.fetching = false;
                if(_this.next_fetch) {
                    _this.fetchComments();
                }
            });
    }

    postComment(comment) {
        var _this = this;
        request
            .post(this.url)
            .send({comment: comment})
            .end(function (err, res) {
                // var chat = res.body;
                // _this.addComment(chat);
            });
    }

    resetInputComment() {
        this.setState({
            inputComment: ''
        });
    }

    setupSubscription() {
        var _this = this;
        App.cable.subscriptions.create('ChatChannel', {
            received(data) {
                if(data.chat_id) {
                    _this.next_fetch = true;
                    this.fetchComments();
                }
            },
            connected() {
                console.log('connected');
                this.connect();
            },
            disconnected() {
                console.log('disconnected');
            },
            connect() {
                this.perform('set_connected', {connect: true});
            },
            fetchComments: this.fetchComments.bind(this)
        });
    }

    render() {
        return (
            <div>
                <input id="comment-input" type="text" onKeyDown={this.onEnter} onChange={this.onChange} value={this.state.inputComment}/>
                <ul>
                    {this.state.comments.map((comment, idx) => {
                        return <li key={idx} dangerouslySetInnerHTML={{__html: comment}}></li>
                    })}
                </ul>
            </div>
        )
    }

}
