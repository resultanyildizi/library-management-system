<template>
  <section style="height: 100%" class="px-8">
    <add-publisher-form ref="addPublisherForm" />
    <circular-progress v-if="!getPublishers" />
    <v-container v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Publisher'"
        :action="fabAction"
      />
      <h1 class="google-sans-regular pl-6 mb-0 text-center">
        🌇 Publishers 🌇
      </h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <publisher-list :publishers="getPublishers" />
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import CircularProgress from "@/components/Core/CircularProgress.vue";
import PublisherList from "@/components/Publisher/PublisherList.vue";
import FloatingActionButton from "../components/Core/FloatingActionButton.vue";
import AddPublisherForm from "../components/Publisher/AddPublisherForm.vue";
export default {
  name: "Publisher",
  components: {
    CircularProgress,
    PublisherList,
    FloatingActionButton,
    AddPublisherForm,
  },

  methods: {
    ...mapActions("publisher", ["bindPublishers"]),
    fabAction() {
      this.$refs.addPublisherForm.dialog = true;
    },
  },
  computed: {
    ...mapGetters("publisher", ["getPublishers"]),
  },
  created() {
    this.bindPublishers();
  },
};
</script>

<style>
</style>