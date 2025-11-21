declare global {
  namespace JSX {
    interface IntrinsicElements {
      'w3m-button': {
        size?: 'sm' | 'md' | 'lg'
        label?: string
        balance?: 'show' | 'hide'
      }
    }
  }
}

export {}
