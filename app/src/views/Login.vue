<template>
  <section class="full d-flex align-center justify-center scrollbar-hidden">
    <v-container>
      <v-row justify="center">
        <v-col cols="12" sm="8" lg="6" xl="4" align="center">
          <app-logo />
          <login-form />
        </v-col>
      </v-row>
    </v-container>
  </section>
</template>


<script>
import AppLogo from "@/components/Core/AppLogo.vue";
import LoginForm from "@/components/Auth/LoginForm.vue";
export default {
  components: { LoginForm, AppLogo },

  name: "Login",
};
</script>

<style>
.full {
  background-color: #d45b5b;
  height: 100%;
}
</style>