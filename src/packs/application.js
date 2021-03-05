// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

class Hello extends React.Component {
  state = { response: null }

  render = () => (
    <div>
    <p>Hello {this.props.name}!</p>
    <p>
    <button onClick={() =>
      fetch("/launch", {
        method: "POST",
        body: JSON.stringify({}),
        headers: {
          'X-CSRF-Token': window._auth_code,
        },
      })
      .then(response => response.json())
      .then(response => this.setState({ response }))
    }>Launch!</button>
    </p>
    <pre>
    {JSON.stringify(this.state.response, null, 2)}
    </pre>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="Hierarch" />,
    document.body.appendChild(document.createElement('div')),
  )
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()
