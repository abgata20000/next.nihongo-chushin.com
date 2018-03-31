import React from 'react'
import {render} from 'react-dom'
import {Provider} from 'react-redux'
import {createStore, applyMiddleware} from 'redux'
import rootReducer from './sample/reducers'
import thunk from 'redux-thunk'
import App from './sample/components/App'

const middleware = [ thunk ];

const store = createStore(
    rootReducer,
    applyMiddleware(...middleware)
);

render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('root')
);
