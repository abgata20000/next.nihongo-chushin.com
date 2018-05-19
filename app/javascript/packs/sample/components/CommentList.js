import React from 'react'
import PropTypes from 'prop-types'
import Comment from './Comment'

const CommentList = ({comments, dispatch}) => (
    <ul>
        {comments.map(comment =>
            <Comment
                key={comment.id}
                {...comment}
                dispatch={dispatch}
            />
        )}
    </ul>
);

CommentList.propTypes = {
    comments: PropTypes.array.isRequired
};

export default CommentList
