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

import styled from "styled-components"

class Hello extends React.Component {
  state = {
    response: null,
    domain: '0.0.0.0',
    package_channel: 3333,
    hierarch_channel: 3334,
  }

  render = () => (
    <div>
      <button onClick={() => {
        fetch("/launch", {
          method: "POST",
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

      { this.state.response &&
      <Block>
        Please see
        &nbsp;
        <a
        href={`http://${this.state.domain}:${this.state.response.channels[0]}`}
        target="_blank"
        >
          http://{this.state.domain}:{this.state.response.channels[0]}
        </a>
        &nbsp;
        so you can begin running Hierarch.
        <br/>
        Please hold. Your program is loading.
      </Block>
    }
    </div>
  )
}

var Block = styled.p`
border: 4px solid #3d3b11;
`

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="Hierarch" />,
    document.body.appendChild(document.createElement('div')),
  )
})

Rails.start()
Turbolinks.start()
ActiveStorage.start()
