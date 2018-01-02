import React from 'react'
var request = require('superagent')

export default class ChatForm extends React.Component {
    chats_url = '/apis/chats';
    room_url = '/apis/rooms';
    users_url = '/apis/rooms/users';
    commentNum = 30;
    fetching = false;
    next_fetch = false;
    lastChatId = 0;

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
        this.fetchRoom();
        this.fetchUsers();
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
                _this.fetching = false;
                if (_this.next_fetch) {
                    _this.fetchComments();
                }
            });
    }

    fetchRoom() {
        var _this = this;
        request
            .get(this.room_url)
            .end(function (err, res) {
                var room = res.body;
                if(room) {
                    _this.setState({
                        roomName: room.room_name
                    })
                }
            });
    }

    fetchUsers() {
        var _this = this;
        request
            .get(this.users_url)
            .end(function (err, res) {
                var users = res.body;
                if(users) {
                    _this.setState({
                        users: users
                    });
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

    setupSubscription() {
        var _this = this;
        App.cable.subscriptions.create('ChatChannel', {
            received(data) {
                if (data.chat_id) {
                    _this.next_fetch = true;
                    this.fetchComments();
                }

                if (data.is_user) {
                    this.fetchUsers();
                }

                if (data.is_room) {
                    this.fetchRoom();
                }

                if(data.is_disconnect) {
                    window.reload();
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
            fetchComments: this.fetchComments.bind(this),
            fetchUsers: this.fetchUsers.bind(this),
            fetchRoom: this.fetchRoom.bind(this)
        });
    }

    render() {
        return (
            <div>
                <div id="room-box">
                    <h2 className="room-name">
                        {this.state.roomName}
                    </h2>
                </div>
                <div id="users-box">
                    <h2>Users</h2>
                    {this.state.users.map((user, idx) => {
                        return <li key={idx} dangerouslySetInnerHTML={{__html: user}}></li>
                    })}
                </div>
                <div id="comments-box">
                    <h2>Comments</h2>
                    <input id="comment-input" type="text" onKeyDown={this.onEnter} onChange={this.onChange}
                           value={this.state.inputComment}/>
                    <ul>
                        {this.state.comments.map((comment, idx) => {
                            return <li key={idx} dangerouslySetInnerHTML={{__html: comment}}></li>
                        })}
                    </ul>
                </div>
            </div>
        )
    }

}
