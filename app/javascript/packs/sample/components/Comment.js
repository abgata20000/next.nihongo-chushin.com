import React from 'react'
import PropTypes from 'prop-types'

const Comment = ({text}) => (
    <li>
        {text}
    </li>
);

Comment.propTypes = {
    text: PropTypes.string.isRequired
};

export default Comment
