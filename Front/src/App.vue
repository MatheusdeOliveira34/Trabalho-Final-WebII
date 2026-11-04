<template>
  <main class="page">
    <form class="card" @submit.prevent="login">
      <h1>Entrar</h1>

      <label>
        Usuário
        <input
          v-model="username"
          name="username"
          autocomplete="username"
          required
        />
      </label>

      <label>
        Senha
        <input
          v-model="password"
          name="password"
          type="password"
          autocomplete="current-password"
          required
        />
      </label>

      <button type="submit" :disabled="loading">
        {{ loading ? 'Entrando...' : 'Entrar' }}
      </button>

      <p v-if="message" class="message" :class="{ ok: success }">{{ message }}</p>
    </form>
  </main>
</template>

<script>
import { localCredentials } from './localCredentials'

export default {
  name: 'App',
  data() {
    return {
      username: localCredentials.username,
      password: localCredentials.password,
      loading: false,
      success: false,
      message: '',
    }
  },
  methods: {
    async login() {
      this.loading = true
      this.success = false
      this.message = ''

      try {
        const response = await fetch('/api/auth/login', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          credentials: 'include',
          body: JSON.stringify({
            username: this.username,
            password: this.password,
          }),
        })
        const data = await response.json().catch(() => ({}))
        this.success = response.ok
        this.message = data.message || 'Não foi possível entrar'
      } catch (error) {
        this.success = false
        this.message = 'Não foi possível falar com o servidor'
      } finally {
        this.loading = false
      }
    },
  },
}
</script>

<style>
html,
body,
#app {
  height: 100%;
  margin: 0;
}

body {
  font-family: system-ui, sans-serif;
  background: #f4f4f5;
  color: #18181b;
}

.page {
  min-height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.card {
  width: 100%;
  max-width: 320px;
  display: flex;
  flex-direction: column;
  gap: 14px;
  padding: 24px;
  background: #fff;
  border: 1px solid #e4e4e7;
  border-radius: 12px;
}

h1 {
  margin: 0 0 4px;
  font-size: 1.5rem;
}

label {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-size: 0.9rem;
}

input {
  padding: 10px 12px;
  border: 1px solid #d4d4d8;
  border-radius: 8px;
  font: inherit;
}

button {
  margin-top: 4px;
  padding: 10px 12px;
  border: 0;
  border-radius: 8px;
  background: #18181b;
  color: #fff;
  font: inherit;
  cursor: pointer;
}

button:disabled {
  opacity: 0.6;
  cursor: default;
}

.message {
  margin: 0;
  font-size: 0.9rem;
  color: #b91c1c;
}

.message.ok {
  color: #15803d;
}
</style>
