<template>
  <section>
    <v-card class="px-4 py-2">
      <v-card-title class="google-sans-medium">Login</v-card-title>
      <v-card-text>
        <v-card v-if="errorMessage" color="secondary" class="mb-4">
          <v-card-text class="white--text google-sans-regular text-body-1">
            <v-icon color="white">mdi-alert-circle</v-icon>
            {{ errorMessage }}
          </v-card-text>
        </v-card>
        <v-form ref="form" v-model="valid" lazy-validation>
          <v-text-field
            v-model="email"
            :rules="emailRules"
            label="Email"
            required
            type="email"
          ></v-text-field>

          <v-text-field
            v-model="password"
            label="Password"
            required
            type="password"
            :rules="passwordRules"
          ></v-text-field>

          <v-row>
            <v-spacer></v-spacer>
            <v-btn
              :disabled="!valid"
              @click="_login()"
              color="secondary"
              :loading="loading"
            >
              Login
            </v-btn>
          </v-row>
        </v-form>
      </v-card-text>
    </v-card>
  </section>
</template>

<script>
import { mapActions } from "vuex";
export default {
  name: "LoginForm",
  data: function () {
    return {
      valid: true,
      loading: false,
      email: null,
      password: null,
      emailRules: [
        (v) => !!v || "E-mail is required",
        (v) =>
          !v ||
          /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "E-mail must be valid",
      ],
      passwordRules: [(v) => !!v || "Password is required"],
      errorMessage: null,
    };
  },

  methods: {
    ...mapActions("auth", ["login"]),
    async _login() {
      this.validate();
      if (this.email && this.password) {
        this.errorMessage = null;
        try {
          this.loading = true;
          const payload = {
            email: this.email,
            password: this.password,
          };

          await this.login(payload);
          this.loading = false;
        } catch (err) {
          this.loading = false;
          this.errorMessage = "Invalid login credentials";
        }
      }
    },

    validate() {
      this.$refs.form.validate();
    },

    resetValidation() {
      this.$refs.form.resetValidation();
    },
  },
};
</script>
