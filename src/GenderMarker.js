export class GenderMarker extends HTMLElement {
  connectedCallback() {
    this.attachShadow({ mode: "open" });
    const text = document.createElement("span");
    text.textContent = "⚧";
    text.style.verticalAlign = "top";
    text.style.fontSize = "0.8em";
    this.shadowRoot.appendChild(text);
    const superscript = document.createElement("sup");
    superscript.style.verticalAlign = "top";
    const slot = document.createElement("slot");
    superscript.appendChild(slot);
    this.shadowRoot.appendChild(superscript);
  }
}

export default GenderMarker;
