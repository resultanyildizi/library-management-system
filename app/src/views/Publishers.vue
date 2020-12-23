<template>
  <section style="height: 100%" class="px-8">
    <add-publisher-form ref="addPublisherForm" />
    <delete-publisher-dialog ref="deletePublisherDialog" />
    <circular-progress v-if="!getPublishers" />
    <v-container v-else>
      <floating-action-button
        :icon="'mdi-plus'"
        :text="'Add new Publisher'"
        :action="fabAction"
      />
      <title-with-menu />
      <v-divider class="my-4 mb-6"></v-divider>
      <publisher-list
        :publishers="getPublishers"
        v-on:openDeleteDialog="openDeleteDialog"
      />
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import CircularProgress from "@/components/Core/CircularProgress.vue";
import PublisherList from "@/components/Publisher/PublisherList.vue";
import FloatingActionButton from "../components/Core/FloatingActionButton.vue";
import AddPublisherForm from "../components/Publisher/AddPublisherForm.vue";
import TitleWithMenu from "../components/Publisher/TitleWithMenu.vue";
import DeletePublisherDialog from "../components/Publisher/DeletePublisherDialog.vue";
export default {
  name: "Publisher",
  components: {
    CircularProgress,
    PublisherList,
    FloatingActionButton,
    AddPublisherForm,
    TitleWithMenu,
    DeletePublisherDialog,
  },

  methods: {
    ...mapActions("publisher", ["bindPublishers"]),
    fabAction() {
      this.$refs.addPublisherForm.dialog = true;
    },
    openDeleteDialog(e) {
      this.$refs.deletePublisherDialog.dialog = true;
      this.$refs.deletePublisherDialog.name = e.name;
      this.$refs.deletePublisherDialog.publisherId = e.publisherId;
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