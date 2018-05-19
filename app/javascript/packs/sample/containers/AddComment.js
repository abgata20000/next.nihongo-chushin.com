import React from 'react'
import {connect} from 'react-redux'
import AddComment from '../components/AddComment'

const mapStateToProps = state => ({
    inputText: state.inputText
});

export default connect(
    mapStateToProps
)(AddComment)
