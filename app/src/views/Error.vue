<template>
  <section>
    <v-container>
      <h1>💀 Sorry, an error occured 💀</h1>
      <code style="color: white; background-color: #f8bf0f"
        >Message: {{ $route.params.error.message }}</code
      >
      <br />
      <br />
      <code>{{ errorJSON }}</code>
    </v-container>
  </section>
</template>

<script>
export default {
  name: "Error",
  created() {
    console.log(this.$route);
  },

  computed: {
    errorJSON() {
      return JSON.stringify(this.$route.params);
    },
  },
};
</script>

<style>
</style>