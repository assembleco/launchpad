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
  state = {
    response: null,
    domain: 'raspberrypi.local',
    package_channel: 3000,
    hierarch_channel: 4321,
  }

  render = () => (
    <div>
    <p>Hello {this.props.name}!</p>
    Domain: <input type="text" value={this.state.domain} onChange={e => this.setState({ domain: e.value })} /><br/>
    Package channel: <input type="text" value={this.state.package_channel} onChange={e => this.setState({ package_channel: e.value })} /><br/>
    Hierarch channel: <input type="text" value={this.state.hierarch_channel} onChange={e => this.setState({ hierarch_channel: e.value })} /><br/>
    <p>
    <button onClick={() => {

      var body = JSON.stringify({
        domain: this.state.domain,
        package_channel: this.state.package_channel,
        hierarch_channel: this.state.hierarch_channel,
      })
      console.log(body)

      fetch("/launch", {
        method: "POST",
        body,
        headers: {
          'X-CSRF-Token': window._auth_code,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      })
      .then(response => response.json())
      .then(response => this.setState({ response }))
    }
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
