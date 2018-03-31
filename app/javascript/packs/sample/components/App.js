import React, {Component} from 'react'
import {connect} from 'react-redux'
import AddComment from '../containers/AddComment'
import CommentList from '../containers/CommentList'
import {fetchComments} from '../actions'
import PropTypes from 'prop-types'

class App extends Component {
    static propTypes = {
        dispatch: PropTypes.func.isRequired
    };

    componentDidMount() {
        this.runFetchComments();
        this.setupSubscription();
    }

    runFetchComments() {
        const {dispatch} = this.props;
        dispatch(fetchComments());
    }

    setupSubscription() {
        Cable.cable.subscriptions.create('ChatChannel', {
            received(data) {
                if (data.chat_id) {
                    this.runFetchComments();
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
            runFetchComments: this.runFetchComments.bind(this),
        });
    }

    render() {
        return (
            <div>
                <AddComment />
                <CommentList />
            </div>
        )
    }
}

const mapStateToProps = (state) => {
    return {
        comments: state.comments
    }
};

export default connect(mapStateToProps)(App)
